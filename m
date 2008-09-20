From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH v2 00/14] Sparse checkout
Date: Sun, 21 Sep 2008 02:48:44 +0700
Message-ID: <fcaeb9bf0809201248w2850a243n50596dda3121f2c@mail.gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
	 <m31vzen4v5.fsf@localhost.localdomain>
	 <fcaeb9bf0809201033o1e9298a8ob135c68228b77218@mail.gmail.com>
	 <200809202001.28383.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 22:01:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kh8e4-0006DE-Qa
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 22:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbYITTss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 15:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbYITTsr
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 15:48:47 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:38046 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbYITTsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 15:48:47 -0400
Received: by fg-out-1718.google.com with SMTP id 19so921933fgg.17
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/EFGLaeZ+sqxNhYqs5SGIZtxTssl1dEZUCtNMuhcDdk=;
        b=vk43WHeJ5qbeP8yjNTU6/0+btLQE2XeHyXLMwRUcIrQNUsxYXgFVFEAsyGYHub+7dP
         oDc8QI6rzDZjmS22av5qzzUPtnGa7PWxC83CcbSjMU1Ipe6pVWO4IXWgFOhNwPufpXNi
         2Iv0UAPx+T0Gpb2SR1/puqhhjdXxl5r+AoIAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TcmbE4i7yz1HAf1Tf24RcGr61DTO/J5Hf1zkpxD9+8hFb/Y6j7e6Qmi7z+w8dJPP10
         FwHbKZHyhlYJiygglS37+GgyAHWVvI6maw2PXA9z6EgWz/HroPI+3c1iSs1+QU1IrcpN
         CPfGcb21FkJGr8rgemcG2oFDEsMHsJcB8R0gM=
Received: by 10.86.52.6 with SMTP id z6mr3365653fgz.18.1221940124544;
        Sat, 20 Sep 2008 12:48:44 -0700 (PDT)
Received: by 10.86.59.5 with HTTP; Sat, 20 Sep 2008 12:48:44 -0700 (PDT)
In-Reply-To: <200809202001.28383.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96363>

On 9/21/08, Jakub Narebski <jnareb@gmail.com> wrote:
>  > "--reset-path", I think, is a better name though. It would express the
>  > relation compared to --add-path and --remove-path.
>
>
> I don't like very much '--reset-path' option name, because it is not
>  about 'reset' or 'resetting', but about limiting checkout to specified
>  paths.  Unfortunately --include / --exclude looks like are for ignoring
>  files, not marking files with "no-checkout" bit etc.
>
>  But I am not native English speaker.
>
>  Further proposals: --only ("git checkout --only <pattern>") with
>  --checkout-only as counterpart in git-clone; --limit-to, --sparse.
>
>
>  GNU tar uses --exclude and --exclude-file (with --no-recurse,
>  --no-wildcards, --no-wildcards-match-slash). wget uses --accept
>  and --reject for filename patterns, and --include / --exclude for
>  directories.  Neither looks right for sparse checkout in Git.

I think --exclude and --include are quite good. With Junio's
suggestion "foo-X", how about this?

git clone --sparse-checkout=<patterns> [1]
git checkout --set-sparse=<patterns>
git checkout --include-sparse=<patterns>
git checkout --exclude-sparse=<patterns> [2]

[1] "checkout" is there to avoid being interpreted as "sparse clone"
[2] --narrow-sparse IMO does not tell how the following patterns are
used (is it the set that will be excluded or the target set?),
"exclude" does better.

>  >>  BTW I think that the same rules are used in gitattributes, aren't
>  >>  they?
>  >
>  > They have different implementations. Though the rules may be the same.
>
>
> Were you able to reuse either one?

No. .gitignore is tied to read_directory() while .gitattributes has
attributes attached. So I rolled out another one for index.
-- 
Duy
