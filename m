From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool merge/skip/abort at prompt
Date: Wed, 28 Jan 2009 00:04:22 -0800
Message-ID: <402731c90901280004l29382eaanedfdfcca75529468@mail.gmail.com>
References: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 09:06:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS5Qt-000556-5x
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 09:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507AbZA1IEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 03:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbZA1IEY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 03:04:24 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:43470 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbZA1IEX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 03:04:23 -0500
Received: by rv-out-0506.google.com with SMTP id k40so6837400rvb.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 00:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WHZJ6qlNxOQqP1oAUUf9EYiy5O4baQtmcQ1Gp+f5RpU=;
        b=oNvYPWA+wB/KjK6wSzDItl/zfilClMuvUOTC5pHtz2aUvAIYKFtgzwvhRRt0qPPnQG
         rWEik32wycKNzNtW6ZlFLdFisZ/yIHF8YmoH1cKKRXr5XKYlje42dGJjNePOFtJR7oEh
         6oqsfKY0WSOLnqTDdOWdREw2NI5Rt+I/Bfw8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JRQfFlfUxBHOQqTrj86tdvwJAQTKbJRDsqSW1k/X7TdZnMun4da70NTQS8bfr9Y03q
         6k0/tXsizSykzBWmpeJeSzErn7vHcR3yVvsIkbJq8+D96uXWI7wBz+UaKAGqBsyJjUug
         BOAO9IJB5xn7K9tsY4M9na4sBnffV6XN4cV+4=
Received: by 10.142.207.8 with SMTP id e8mr198698wfg.199.1233129862664; Wed, 
	28 Jan 2009 00:04:22 -0800 (PST)
In-Reply-To: <81bfc67a0901272256t726bf206k351bb6c8b2778bd5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107503>

Hi Caleb

On Tue, Jan 27, 2009 at 10:56 PM, Caleb Cushing <xenoterracide@gmail.com> wrote:
> previously git mergetool when run with prompt only allowed the user to continue
> merging. This changes git mergetool to allow the option of skipping a file or
> aborting, and includes an addtional key to explicitly select merge.
>
> Signed-off-by: Caleb Cushing <xenoterracide@gmail.com>
> ---
>  git-mergetool.sh |   20 ++++++++++++++++++--
>  1 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 00e1337..575fbb2 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -177,8 +177,24 @@ merge_file () {
>     describe_file "$local_mode" "local" "$LOCAL"
>     describe_file "$remote_mode" "remote" "$REMOTE"
>     if "$prompt" = true; then
> -       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
> -       read ans
> +       while true; do
> +           printf "Use (m)erge file or (s)kip file, or (a)bort? (%s): " \


I really like the feature you added here.  I'm sorry to bikeshed on
this conversation, but after trying it I have one tiny suggestion.

Right now the prompt looks like this with your patch:

"""
Merging the files: foo bar baz

Normal merge conflict for 'foo':
  {local}: created
  {remote}: created
Use (m)erge file or (s)kip file, or (a)bort? (xxdiff): m
"""

do you think
"Use merge file or skip file, or abort?"
might be better expressed as:

"""
Merging: foo bar baz

Normal merge conflict for 'foo':
  {local}: created
  {remote}: created
(m)erge, (s)kip, or (q)uit? (xxdiff): m
"""?

I realize that your patch only touches the last line of the prompt
(and not the introductory "Merging the files:" line) so if you agree
then maybe I can throw a patch together for the introductory line.

Also, my example has quit instead of abort for two reasons (the first
one is silly)
1. skip rhymes with quit, so it reads very nicely out loud
2. consistency with git add --interactive
3. less typos (q and s are diagonal on qwerty, s and a are adjacent)
(okay, that last one is silly too)

Some might also mis-associate 'abort' with meaning "abort the merge."

slightly off-topic:
If we're looking at cleaning up mergetool a bit would you all mind a
separate patch to convert it to using hard tabs throughout, just like
git-rebase.sh?


> +           "$merge_tool"
> +           read ans
> +           case "$ans" in
> +               [mM]*|"")
> +                   break
> +                   ;;
> +               [sS]*)
> +                   cleanup_temp_files
> +                   return 0
> +                   ;;
> +               [aA]*)
> +                   cleanup_temp_files
> +                   exit 0
> +                   ;;
> +           esac
> +       done
>     fi
>
>     case "$merge_tool" in
> --
> 1.6.1.1
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
    David
