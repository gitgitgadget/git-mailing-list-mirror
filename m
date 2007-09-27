From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Thu, 27 Sep 2007 15:23:44 -0700
Message-ID: <94ccbe710709271523s7e4c7a1dh53e34bd460c31d1f@mail.gmail.com>
References: <94ccbe710709271131o620bf1far8893328ce98f0ba4@mail.gmail.com>
	 <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	 <7vd4w3ua2j.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
	 <7v8x6ru97z.fsf@gitster.siamese.dyndns.org>
	 <7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
	 <94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com>
	 <94ccbe710709271422x5d1739c2g5da961c88a4336fe@mail.gmail.com>
	 <7vmyv7sshv.fsf@gitster.siamese.dyndns.org>
	 <7vir5vss58.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Theodore Ts'o" <tytso@mit.edu>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:24:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib1m0-0004Nr-J5
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 00:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664AbXI0WXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 18:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758446AbXI0WXs
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 18:23:48 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:19593 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652AbXI0WXr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 18:23:47 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3327650wah
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=V6L2B4naqlCT5Zj7lFZdhaZdWrREvNVDWH86fi2XElQ=;
        b=QP0GnvQ/B194zgR6W2LXFvqz114p04T/a3+gRBYBmJuvPjGd+MK6/1FrGq6FPbm5mJntYRMpTHMwRiYoAfZXs9Dh65rItHXAa6yT4voLpgP+14SkamVxjVm+Pc/73uMEbNdsgOFfVMrRUhg/WRtpPlHjLB6a6V9FUHrbxkcgaoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=com3oBn+V4pjWvQgVo/HYxhruv8+h2g+YuTSgvBuIt5hayGptKoEAUGJhZ5HHxMWbwidSZXPDBE12lGnb08nve9k9wMfrarMW6xO0O6Brn5cG5m4kAUeA5RtpPY12Q0f2pID86ny40C300T3JZ5+b467ulqE6hfIW+t3zpuD+5Q=
Received: by 10.114.78.1 with SMTP id a1mr1103685wab.1190931824729;
        Thu, 27 Sep 2007 15:23:44 -0700 (PDT)
Received: by 10.114.144.17 with HTTP; Thu, 27 Sep 2007 15:23:44 -0700 (PDT)
In-Reply-To: <7vir5vss58.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Google-Sender-Auth: 5af60f085656da85
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59344>

On 9/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> When mergetool is run from a subdirectory, "ls-files -u" nicely
> limits the output to conflicted files in that directory, but
> we need to give the full path to cat-file plumbing to grab the
> contents of stages.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * I earlier sent one with cd_to_toplevel but I think the
>    approach in this patch is nicer.
>
>  git-mergetool.sh |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index a0e44f7..3b1ec13 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -12,6 +12,7 @@ USAGE='[--tool=tool] [file to merge] ...'
>  SUBDIRECTORY_OK=Yes
>  . git-sh-setup
>  require_work_tree
> +prefix=$(git rev-parse --show-prefix)
>
>  # Returns true if the mode reflects a symlink
>  is_symlink () {
> @@ -162,9 +163,9 @@ merge_file () {
>      local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
>      remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
>
> -    base_present   && git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
> -    local_present  && git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
> -    remote_present && git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
> +    base_present   && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null
> +    local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
> +    remote_present && git cat-file blob ":3:$prefix$path" >"$REMOTE" 2>/dev/null
>
>      if test -z "$local_mode" -o -z "$remote_mode"; then
>         echo "Deleted merge conflict for '$path':"
>

--- a/git-mergetool       2007-09-24 09:08:23.000000000 -0700
+++ b/git-mergetool        2007-09-27 15:04:15.000000000 -0700
@@ -12,6 +12,7 @@
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
 require_work_tree
+prefix=$(git rev-parse --show-prefix)

 # Returns true if the mode reflects a symlink
 is_symlink () {
@@ -162,9 +163,9 @@
     local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
     remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`

-    base_present   && git cat-file blob ":1:$path" > "$BASE" 2>/dev/null
-    local_present  && git cat-file blob ":2:$path" > "$LOCAL" 2>/dev/null
-    remote_present && git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
+    base_present   && git cat-file blob ":1:$prefix$path" > "$BASE" 2>/dev/null
+    local_present  && git cat-file blob ":2:$prefix$path" > "$LOCAL"
2>/dev/null
+    remote_present && git cat-file blob ":3:$prefix$path" > "$REMOTE"
2>/dev/null

     if test -z "$local_mode" -o -z "$remote_mode"; then
        echo "Deleted merge conflict for '$path':"
@@ -251,7 +252,7 @@
            ;;
        emerge)
            if base_present ; then
-               emacs -f emerge-files-with-ancestor-command "$LOCAL"
"$REMOTE" "$BASE" "$path"
+               emacs -f emerge-files-with-ancestor-command "$LOCAL"
"$REMOTE" "$BASE" "$(basename "$path")"
            else
                emacs -f emerge-files-command "$LOCAL" "$REMOTE"
"$(basename "$path")"
            fi



Finally got it to work.  emacs (at least the version I'm using,
22.1.1) seems to set the $PWD via its first argument, that is,
$LOCAL's directory, and when it goes to save, it tries to save $path
on top of that.

The updated patch above would be just to use the basename, that is, if
it is certain that $LOCAL and $path will always reside in the same
directory -- and I believe, but am not certain, that this is the case.

Also, I am not sure if this is specific to my version of Emacs, so
perhaps some further testing is required.

-- 
Kelvie
