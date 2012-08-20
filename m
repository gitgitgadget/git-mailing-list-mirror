From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: Re: [PATCH] fast_export.c: Fix a compiler warning
Date: Mon, 20 Aug 2012 08:19:25 +0200
Message-ID: <2715225.vOk3BtNY6o@flomedio>
References: <5031063E.3090405@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: florian.achleitner.2.6.31@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:19:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3LL5-0000CQ-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 08:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754393Ab2HTGTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 02:19:40 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40508 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab2HTGTe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 02:19:34 -0400
Received: by wicr5 with SMTP id r5so3399806wic.1
        for <git@vger.kernel.org>; Sun, 19 Aug 2012 23:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=/bLZOzbxToNEHrahhJ4X4NMPWcvPfpamUPc2EmQcynU=;
        b=wYkgJr98gwRvhc9hcrMB7zc6LzKefAu2YFLZ/OVZuLbd4d5+fJijHbb4xmp2nSoafp
         P3L1xyZPxaEmRFHBurfyZV4hgLNf2AuwFDDAYKejCs54Mhi5B/fejgbpAgDLIZQKkEof
         QnGLkJ6UhpPVSIv3/7R3qYpkRBBq6X8BXwvrMzhTN5Vz8R6IOoNpSgM5y9+Ibu9ISoGd
         Ia89HKggBRfmrQfCtIVhU638yzlNlRLaf3cBRswscOy51REzRf7LPipf5sBwbVjojlGw
         vPeh/DlbU7gCsfmv0rRPpczb7b28mrTu5wRmzKuT4p5h1LZXErck0K7rn+NEOxK4LCdP
         eodg==
Received: by 10.216.136.167 with SMTP id w39mr7334918wei.76.1345443572499;
        Sun, 19 Aug 2012 23:19:32 -0700 (PDT)
Received: from flomedio.localnet (089144206224.atnat0015.highway.a1.net. [89.144.206.224])
        by mx.google.com with ESMTPS id o2sm39219551wiz.11.2012.08.19.23.19.29
        (version=SSLv3 cipher=OTHER);
        Sun, 19 Aug 2012 23:19:31 -0700 (PDT)
User-Agent: KMail/4.8.4 (Linux/3.0.0-24-generic; KDE/4.8.4; x86_64; ; )
In-Reply-To: <5031063E.3090405@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203757>

On Sunday 19 August 2012 16:29:02 Ramsay Jones wrote:
> In particular, gcc complains thus:
> 
>         CC vcs-svn/fast_export.o
>     vcs-svn/fast_export.c: In function 'fast_export_begin_note':
>     vcs-svn/fast_export.c:77: warning: long long unsigned int format, \
>         different type arg (arg 2)
> 
> In order to fix the warning, we cast the second size_t argument in
> the call to printf to uintmax_t.
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
> 
> Hi Florian,
> 
> If you need to re-roll your patches in the 'fa/remote-svn' branch, could
> you please squash this fix into them. [This was implemented on top of
> commit 2ce959ba, but you will probably want to make the equivalent change
> to commit d319a37c ("Create a note for every imported commit containing
> svn metadata", 17-08-2012) instead. Note that, because of the context
> lines in the patch, it won't apply as-is.]

Ok, I'll add it to the next version. This warning only occurs when building 
for 32bit, thus I never saw it. There would be a format flag for printf that 
sprecifies the platform's size_t integer type: "z". 
Probalby we should use it instead? I don't know how widely supported it is.
> 
> Thanks!
> 
> ATB,
> Ramsay Jones

Thanks,
Florian

> 
>  vcs-svn/fast_export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index c780d32..dd09c7d 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -74,7 +74,7 @@ void fast_export_begin_note(uint32_t revision, const char
> *author, size_t loglen = strlen(log);
>  	printf("commit %s\n", note_ref);
>  	printf("committer %s <%s@%s> %ld +0000\n", author, author, "local",
> timestamp); -	printf("data %"PRIuMAX"\n", loglen);
> +	printf("data %"PRIuMAX"\n", (uintmax_t) loglen);
>  	fwrite(log, loglen, 1, stdout);
>  	if (firstnote) {
>  		if (revision > 1)
