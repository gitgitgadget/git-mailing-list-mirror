From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT PATCH 2/2] Don't touch ref files manually
Date: Tue, 21 Aug 2007 14:23:29 +0100
Message-ID: <b0943d9e0708210623h112faa42p97bba06bc9fab774@mail.gmail.com>
References: <20070810031949.19791.54562.stgit@yoghurt>
	 <20070810032318.19791.70483.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Pavel Roskin" <proski@gnu.org>, git@vger.kernel.org,
	"Yann Dirson" <ydirson@altern.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 15:23:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INThq-0007Uv-Tx
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 15:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbXHUNXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 21 Aug 2007 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756355AbXHUNXd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 09:23:33 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60846 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbXHUNXc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 09:23:32 -0400
Received: by nf-out-0910.google.com with SMTP id g13so876910nfb
        for <git@vger.kernel.org>; Tue, 21 Aug 2007 06:23:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jSOqVtU22HCabG07+jkjDl3ccxM8LsMhlvTY0rgCAhA5/iXhWrTqDyDUdxtWHjkJr7BYTUIeUw2GVapUmm4VeKJAyu4PSIus/cF5oudQ6+d02vE+5S3Kzc1EBJ2/0tfCgf0+LCuiJVvDoAFEZHHanOjxUsjrCrGORHZSDr91pRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=deac71ulGWGmeLT7soW4zOl5K2quI9usDbwI39c21jr1h4VKYfEZ3yPp5I0WCqXLbgSwT6mhQ2xJHw7CSGqP/B9Tu3iY5r9o+lzFj46XQNfWBEDXmNVcRdkbMKI34n+Pq48EikXMMfBAixzpJe1umzaIX5JFt3Q5yUViKukGZIU=
Received: by 10.78.188.10 with SMTP id l10mr2780206huf.1187702609222;
        Tue, 21 Aug 2007 06:23:29 -0700 (PDT)
Received: by 10.78.151.20 with HTTP; Tue, 21 Aug 2007 06:23:29 -0700 (PDT)
In-Reply-To: <20070810032318.19791.70483.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56295>

Hi Karl,

On 10/08/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Messing with files manually doesn't work if the refs are packed. The
> officially preferred way is to use git-update-ref, git-show-ref,
> et.al. So do that.

Thanks for this patch. I'll apply it but I have some questions below.

> @@ -294,14 +301,16 @@ def set_head_file(ref):
>      # head cache flushing is needed since we might have a different =
value
>      # in the new head
>      __clear_head_cache()
> -    if __run('git-symbolic-ref HEAD',
> -             [os.path.join('refs', 'heads', ref)]) !=3D 0:
> +    if __run('git-symbolic-ref HEAD', ['refs/heads/%s' % ref]) !=3D =
0:
>          raise GitException, 'Could not set head to "%s"' % ref

Why replacing os.path.join with a single string? I think the former is
more portable if, in the future, someone will try to run StGIT on
Windows (and GIT would be compiled directly, without cygwin).

> diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
> index cca5504..e920e93 100755
> --- a/t/t1000-branch-create.sh
> +++ b/t/t1000-branch-create.sh
> @@ -13,26 +13,9 @@ Exercises the "stg branch" commands.
>  stg init
>
>  test_expect_success \
> -    'Create a spurious refs/patches/ entry' '
> -    find .git -name foo | xargs rm -rf &&
> -    touch .git/refs/patches/foo

I haven't tried this test but is there any problem if we keep them?

Thanks.

--=20
Catalin
