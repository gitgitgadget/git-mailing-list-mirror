From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH 1/3] git-submodule: rename shell functions for consistency
Date: Wed, 16 Jan 2008 08:26:29 +0600
Message-ID: <7bfdc29a0801151826u2218f825ga8100b1cc9fa8b2@mail.gmail.com>
References: <1200280956-19920-1-git-send-email-imyousuf@gmail.com>
	 <7vzlv7flb5.fsf@gitster.siamese.dyndns.org>
	 <7vy7are3qo.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:27:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JExzn-0005Xc-Cs
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 03:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755126AbYAPC0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 21:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752501AbYAPC0c
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 21:26:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:27702 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYAPC0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 21:26:31 -0500
Received: by fg-out-1718.google.com with SMTP id e21so88097fga.17
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 18:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Rt3/sNhoU6rIdSa01S+oeomy/ayInZHibvNkJK4rTPI=;
        b=IdcBHFKdkzjL19p1W7kKv0PINIRze64Nin3onaneilnTL35OEFtEPIC1QpuRxgSTzuecH5AzmdV6i7U9NNjuw4hz+sR5r3C2S8P/q0UsK+HzD3x/eRXi+zqMVJKPeUWDzAGlk0c2Gf9VeuL8I4q8QecLGxxYjv5NfBbiQJFZlBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QbKEOCIzq7Z4//6k7NzmNmUgsoTNYKlSY28WukqXC3t4Vapy2HTCJ6UvXeIVUI5p2ulRJHs3PeZWZxyqueA6c0ZvnDiVpZYBzkQFV8g+3B4KAYmX2zLq/VA9sbG0wOMyJ7U9MdLH/t+xwoYFxU5rD0YMYr9K3UzV1+hWOalxAMQ=
Received: by 10.78.166.7 with SMTP id o7mr251330hue.31.1200450389898;
        Tue, 15 Jan 2008 18:26:29 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Tue, 15 Jan 2008 18:26:29 -0800 (PST)
In-Reply-To: <7vy7are3qo.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70607>

Thanks Junio for showing how it should be done. Due to some
pre-scheduled appointment I was unavailable yesterday evening and thus
was neither able to reply nor resubmit the changes.

On Jan 15, 2008 5:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> This renames the shell functions used in git-submodule that
> implement top-level subcommands.  The rule is that the
> subcommand $foo is implemented by cmd_$foo function.
>
> A noteworthy change is that modules_list() is now known as
> cmd_status().  There is no "submodule list" command.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * We could probably do something like this.  This first part is
>    about making the command dispatcher maintainable.
>
>    Note that I haven't seriously tested this series.  This and
>    the next one are primarily to illustrate what I think the fix
>    you are trying should look like.
>
>  git-submodule.sh |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index ad9fe62..3c104e3 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -86,9 +86,9 @@ module_name()
>  #
>  # Clone a submodule
>  #
> -# Prior to calling, modules_update checks that a possibly existing
> +# Prior to calling, cmd_update checks that a possibly existing
>  # path is not a git repository.
> -# Likewise, module_add checks that path does not exist at all,
> +# Likewise, cmd_add checks that path does not exist at all,
>  # since it is the location of a new submodule.
>  #
>  module_clone()
> @@ -121,7 +121,7 @@ module_clone()
>  #
>  # optional branch is stored in global branch variable
>  #
> -module_add()
> +cmd_add()

After reading your reply I was about to suggest renaming module to cmd
but you have done it before I could propose or submit the patch.

>  {
>         repo=$1
>         path=$2
> @@ -174,7 +174,7 @@ module_add()
>  #
>  # $@ = requested paths (default to all)
>  #
> -modules_init()
> +cmd_init()
>  {
>         git ls-files --stage -- "$@" | grep -e '^160000 ' |
>         while read mode sha1 stage path
> @@ -207,7 +207,7 @@ modules_init()
>  #
>  # $@ = requested paths (default to all)
>  #
> -modules_update()
> +cmd_update()
>  {
>         git ls-files --stage -- "$@" | grep -e '^160000 ' |
>         while read mode sha1 stage path
> @@ -266,7 +266,7 @@ set_name_rev () {
>  #
>  # $@ = requested paths (default to all)
>  #
> -modules_list()
> +cmd_status()
>  {
>         git ls-files --stage -- "$@" | grep -e '^160000 ' |
>         while read mode sha1 stage path
> @@ -347,16 +347,16 @@ esac
>
>  case "$add,$init,$update,$status,$cached" in
>  1,,,,)
> -       module_add "$@"
> +       cmd_add "$@"
>         ;;
>  ,1,,,)
> -       modules_init "$@"
> +       cmd_init "$@"
>         ;;
>  ,,1,,)
> -       modules_update "$@"
> +       cmd_update "$@"
>         ;;
>  ,,,*,*)
> -       modules_list "$@"
> +       cmd_status "$@"
>         ;;
>  *)
>         usage
> --
> 1.5.4.rc3.11.g4e67
>
>



-- 
Imran M Yousuf
