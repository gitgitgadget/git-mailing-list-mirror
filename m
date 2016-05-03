From: Shin Kojima <shin@kojima.org>
Subject: [PATCH v2] gitweb: apply fallback encoding before highlight
Date: Tue,  3 May 2016 22:00:51 +0900
Message-ID: <1462280451-43388-1-git-send-email-shin@kojima.org>
References: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christopher Wilson <cwilson@cdwilson.us>,
	Jakub Narebski <jnareb@gmail.com>,
	Shin Kojima <shin@kojima.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 15:01:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axZx6-0005pw-Vw
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 15:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933420AbcECNBO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2016 09:01:14 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35649 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932762AbcECNBM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 09:01:12 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so1949868pfr.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kojima-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKZV5Wr4sHLrhEsYy/C62gUgHtwq6xBtObZUtu54MnQ=;
        b=cG24UdB806x+9Etd7yLjTT2B9BpHSN/MijbsrUmO5um+zmP4xSeSQ9pAYA4uNLGgON
         2swZxUYmDuXrXizbaTI24BzwWFXZ9G74mLhsXlgV9H2EMAIbxg5IoOhtNA+i3ezK/qO7
         KgSpBZVTqu6WGWn3mE/K6sbvp8C4LpFh+0OXbCnoLbDteQyy1w0ANXKc0hq7H1yaEDGW
         Xy6linwvuAR58dv/MBZC/9M+ajDkkgNcVfGAZC1WJ3hp+n3vhp6vnY5EY6+LwVZOj2Xx
         PqSnICIdy/zzTSf1cym/4mvoiHr+nvhFZlmhnxGLhZq9rKxUahc1DGN73v2TbJ9no8yr
         hA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKZV5Wr4sHLrhEsYy/C62gUgHtwq6xBtObZUtu54MnQ=;
        b=hcE7izj9TwzTEaoePGpwIS4bphaZUsIa4+Sx/ggB7EWdUw9gfEQKBK1jJhVPSl3pbT
         cHDbgl+qbraq2dPO1WXzQRfsmplzJVn+m8WTrMDhS3XLZ69JFkPjGD7lHjwA2dgKD7qo
         nbyN1yquJwgcX5N7zTIXsvJ1apQ/jle3Xq7AyKTXZXIvvLv6ftC9r9gcbczicEP4tYjH
         7VZs2zgagmvuz9sG2IQMVu3J3Ww2GWBj2uUbj9y7HZlpda+W7OPLDaAG7Zzjnz8DabzQ
         lKuKHBpeRooGBUA7JqdgDNuCC0/oS0ayBcxyIUVOqeksZTeQuHpMHE6dUZwpqEiCwNoT
         XLkA==
X-Gm-Message-State: AOPr4FXhoen9+jDUyFoMpDrR9KrdpjWFkBokAk5kbqfUGkl0+U2T85M5NZ/r25mxD59Yyg==
X-Received: by 10.98.67.143 with SMTP id l15mr3238149pfi.114.1462280470883;
        Tue, 03 May 2016 06:01:10 -0700 (PDT)
Received: from localhost.localdomain (182-167-204-232f1.hyg1.eonet.ne.jp. [182.167.204.232])
        by smtp.gmail.com with ESMTPSA id 8sm5884556pfk.69.2016.05.03.06.01.08
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 03 May 2016 06:01:09 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293397>

Some multi-byte character encodings (such as Shift_JIS and GBK) have
characters whose final bytes is an ASCII '\' (0x5c), and they
will be displayed as funny-characters even if $fallback_encoding is
correct.  This is because `highlight` command always expects UTF-8
encoded strings from STDIN.

    $ echo 'my $v =3D "=E7=94=B3";' | highlight --syntax perl | w3m -T =
text/html -dump
    my $v =3D "=E7=94=B3";

    $ echo 'my $v =3D "=E7=94=B3";' | iconv -f UTF-8 -t Shift_JIS | hig=
hlight \
        --syntax perl | iconv -f Shift_JIS -t UTF-8 | w3m -T text/html =
-dump

    iconv: (stdin):9:135: cannot convert
    my $v =3D "

This patch prepare git blob objects to be encoded into UTF-8 before
highlighting in the manner of `to_utf8` subroutine.

Signed-off-by: Shin Kojima <shin@kojima.org>
---

Changes for v2:
    - Add Signed-off-by

Thanks,
Shin Kojima

 gitweb/gitweb.perl | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 05d7910..2fddf75 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3935,6 +3935,9 @@ sub run_highlighter {
=20
 	close $fd;
 	open $fd, quote_command(git_cmd(), "cat-file", "blob", $hash)." | ".
+	          quote_command($^X, '-CO', '-MEncode=3Ddecode,FB_DEFAULT', '=
-pse',
+	            '$_ =3D decode($fe, $_, FB_DEFAULT) if !utf8::decode($_);=
',
+	            '--', "-fe=3D$fallback_encoding")." | ".
 	          quote_command($highlight_bin).
 	          " --replace-tabs=3D8 --fragment --syntax $syntax |"
 		or die_error(500, "Couldn't open file or run syntax highlighter");
--=20
2.8.2
