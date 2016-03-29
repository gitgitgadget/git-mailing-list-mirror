From: Elliott Cable <me@ell.io>
Subject: `git rev-parse --git-dir` relative to current working directory?
Date: Tue, 29 Mar 2016 05:32:31 -0500
Message-ID: <CAPZ477NfQ7pCiHQ3V42kZ1Cic5UPP03TCFPvABR_ugSZYEn4xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 12:32:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akqxE-0007oP-RG
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 12:32:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcC2Kcy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 06:32:54 -0400
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35393 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbcC2Kcw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 06:32:52 -0400
Received: by mail-vk0-f42.google.com with SMTP id e6so12842567vkh.2
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 03:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xwg8uw5TcdiATO7GMzSer1yOmO552wNbgSxEMDIJAJE=;
        b=LOh0GZiAqiexRp3eca3iIhR2AKGUJQ5K1qH5DEoHZFstGq0JyZIZ1BFiSq3Syh/Nki
         Z3CQq+yajptKH1uZ9RwigRFiCoSbSBoPnO+EWO+dNfiHfAa1JxUfDT313hF93NLMa5UR
         AG/i5uQ25TwDhcj+Wwdf5+hsZsV7StboEOuJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=xwg8uw5TcdiATO7GMzSer1yOmO552wNbgSxEMDIJAJE=;
        b=h16ohNsX4YYAuuL/k+OYqcAj72+5z9VzwfLalpaggACKyT3+E2Fe6IFel+gpNL622l
         W88raN/W2f6DMVoD1u2rPL29fTGH/1/NIDwF28JyM51PMJOAzJTh7zLGBR7DqOozPRrB
         9SRRdli3QZFfj7XF6NYMVs9apVFuucs4niZ8KwZHCzXuNzsJFTd14/kLBXEl7yQwLYoV
         mhFQpxgbYyZhRmwd//yYCYnW53QrbSPSvKT0ij7oquZGgC6eYx4gYC6qc86zJXOEEyFo
         m9/c6QbbLzXM274AKiXM26LMPPLU2GnUQR0nqqaib90nfBHYoW3VdCQibESdsUeDMxdA
         +Dmg==
X-Gm-Message-State: AD7BkJLPqn7lGW4SXvWB8OBkB+WqoYpQqN1cCAQkXqEn2ViC+fhcfmkPxO23aBFqRporwR0AfFc6BvEBNzOAug==
X-Received: by 10.159.40.168 with SMTP id d37mr695708uad.83.1459247571241;
 Tue, 29 Mar 2016 03:32:51 -0700 (PDT)
Received: by 10.31.92.206 with HTTP; Tue, 29 Mar 2016 03:32:31 -0700 (PDT)
X-Originating-IP: [204.14.154.168]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290113>

So, `git help rev-parse` [mentions the following][rev-parse], as of
2.8.0:

    --git-dir
       Show $GIT_DIR if defined. Otherwise show the path to the .git
       directory. The path shown, when relative, is relative to the
       current working directory.

However, when inside a symlinked repository, this doesn't function as
advertised:

    $ ln -s a-symlink a-git-repo
    $ cd a-symlink/.git/hooks
    $ git rev-parse --git-dir
    /Users/ec/Documents/a-git-repo/.git

=46rom my reading of that snippet of documentation (=E2=80=9CThe path s=
hown ... is
relative to the CWD=E2=80=9D), I'd expect to receive `..`, not
`/absolute/path/to/a-git-repo/.git`.

Is the documentation incorrect, or is this a bug? (I'm hoping the
latter: I'm trying to write git-scripting that is sensitive to symlinks=
,
i.e. retains the user's CWD without unintentionally resolving symlinks
in their path during operation; and it'd be ideal if this were handled
as documented, saving me manual effort checking symlinks.)


=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt

   [rev-parse]:
<https://git-scm.com/docs/git-rev-parse/2.8.0#_options_for_files>
      "git rev-parse documentation @2.8.0"
