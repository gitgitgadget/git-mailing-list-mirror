From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 13:17:33 -0400
Message-ID: <CAPig+cR=u_ak_=J=gSAWfiNB01R7FBG+bCrx+k1HNAE0xHtwFQ@mail.gmail.com>
References: <205a18f7f8a7892a1fa63a91a84bfd9b@drbeat.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
To: Beat Bolli <dev+git@drbeat.li>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:18:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG9Gr-00087S-Lu
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbbGQRR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 13:17:56 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33857 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbbGQRRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:17:35 -0400
Received: by ykax123 with SMTP id x123so94903332yka.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hIJz7azw90vAO1HegGJ03lfrQBF09Ntr9GupF88GO48=;
        b=RQBTAicHCdRpyAxG4KNfZIL+BTLVAfIKr1u+RZN5CfAyi0qB53LD9Xa3G6lLGsPYhm
         T/BXkaHLVJ7QibUJcwR80ZSrYJ9ro5sGYsYn2DZnTZ18uMOp0/RcVgKTqseS6AFmos9v
         qDtrt92IPVsK3AMbAxWnyebSFPazmB7JXtWemqyPNkJUXUCjbj46Xy6PIf9u2IPSnd3v
         hYvSEI6xV1Rp6lIrqh4FpsMxBou5hhQbwV/EnAbKs2CI3ELEYOKzJhkYTfuQgBjQXqkh
         MxU8HPay5rxlSwopNGAwajsQQKLx1szKlxP6lMDR/wN221y8D0VkgvYKJ6dSyuFaHShX
         s84g==
X-Received: by 10.170.138.134 with SMTP id f128mr16531456ykc.90.1437153454001;
 Fri, 17 Jul 2015 10:17:34 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 17 Jul 2015 10:17:33 -0700 (PDT)
In-Reply-To: <205a18f7f8a7892a1fa63a91a84bfd9b@drbeat.li>
X-Google-Sender-Auth: VWE8b-EphKrSTeI_4Tymfnh7Xls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274090>

On Fri, Jul 17, 2015 at 4:39 AM, Beat Bolli <dev+git@drbeat.li> wrote:
> When referring to earlier commits in commit messages or other text, one
> of the established formats is
>
>     <abbrev-sha> ("<summary>", <author-date>)
>
> Add a "Copy commit summary" command to the context menu that puts this
> text for the currently selected commit on the clipboard. This makes it
> easy for our users to create well-formatted commit references.
>
> The <abbrev-sha> is produced with the %h format specifier to make it
> unique. Its minimum length can be controlled with the config setting
> core.abbrev.
>
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> Reviewed-by: Johannes Sixt <j6t@kdbg.org>

You should drop these Reviewed-by: footers, as they imply that the
code was thoroughly digested and the implementation deemed correct.
Hannes at least gave advice about abbreviation length and may deserve
mention via a Helped-by: footer (if you take his advice and feel his
contribution worthy); however, in my case, I merely made a very minor
observation about the output format, not even worth a Helped-by: (and
certainly not a Reviewed-by:).

> Cc: Paul Mackerras <paulus@samba.org>
>
> ---
> Changes since v2:
> - call git log to produce a unique <abbrev-sha>
> - use the short date format
>
> Changes since v1:
> - drop the "commit " literal in front of the <abbrev-sha>
> ---
>  gitk-git/gitk | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 9a2daf3..4915f53 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2617,6 +2617,7 @@ proc makewindow {} {
>         {mc "Diff selected -> this" command {diffvssel 1}}
>         {mc "Make patch" command mkpatch}
>         {mc "Create tag" command mktag}
> +       {mc "Copy commit summary" command copysummary}
>         {mc "Write commit to file" command writecommit}
>         {mc "Create new branch" command mkbranch}
>         {mc "Cherry-pick this commit" command cherrypick}
> @@ -9341,6 +9342,17 @@ proc mktaggo {} {
>      mktagcan
>  }
>
> +proc copysummary {} {
> +    global rowmenuid
> +
> +    set format "%h (\"%s\", %ad)"
> +    set summary [exec git show -s --pretty=format:$format --date=short \
> +                 $rowmenuid]
> +
> +    clipboard clear
> +    clipboard append $summary
> +}
> +
>  proc writecommit {} {
>      global rowmenuid wrcomtop commitinfo wrcomcmd NS
>
> --
> 2.4.0
