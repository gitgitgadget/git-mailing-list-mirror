From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH v2] Fix testcase failure when extended attributes are
	in use
Date: Sun, 19 Oct 2008 19:47:23 -0400
Message-ID: <20081019234723.GB2015@riemann.deskinm.fdns.net>
References: <20081011154107.GA14994@riemann.deskinm.fdns.net> <20081014021016.GB14994@riemann.deskinm.fdns.net> <7vbpxig4fb.fsf@gitster.siamese.dyndns.org> <20081019122419.GA2015@riemann.deskinm.fdns.net> <7viqro73w5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, heikki.orsila@iki.fi
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 10:29:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kri4E-0007ED-NO
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 01:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYJSXuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Oct 2008 19:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751957AbYJSXuq
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Oct 2008 19:50:46 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:36641 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbYJSXup (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Oct 2008 19:50:45 -0400
Received: by gxk9 with SMTP id 9so3079951gxk.13
        for <git@vger.kernel.org>; Sun, 19 Oct 2008 16:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=B3qTMN0kH8tp0Lpy9V3TH6U2oUv5/pr+LwGDdT+QsG0=;
        b=Bq3TimleEt2hFB9qv7JXmBNHdteJ3v0G+9i/UhL/zHsk/77frYHJZzkUK2ZMcwugED
         GgAdDUin69F54kB6Z2IV9vwUw0gM7IQvwUlvUC0eaGYel8GSHNLS5GLszwc1JXedDjta
         ARy5DKtEyLzQ5CZdYXr9lmKlLQeQM2POWCWO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=wp6P019WkbY7CaJRxcwFACnb2DxY5pseqshLQ4bbTJeV7x4o/JxuG9sFl8GA6/+72H
         16CzwPF6FIS+60ro6FrMmX11j1bwjVW+5qJRNKwW2kwv2R5ulnJc/OSuzY+t3/vCaT7P
         lSkYoQ1a62lvUzoWWXdibiLlTNLArTTgx06tg=
Received: by 10.150.156.9 with SMTP id d9mr11015336ybe.221.1224460244468;
        Sun, 19 Oct 2008 16:50:44 -0700 (PDT)
Received: from riemann.deskinm.fdns.net ([68.40.49.130])
        by mx.google.com with ESMTPS id z26sm10511768ele.7.2008.10.19.16.50.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Oct 2008 16:50:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7viqro73w5.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98625>

On Sun, Oct 19, 2008 at 12:59:06PM -0700, Junio C Hamano wrote:
> Deskin Miller <deskinm@umich.edu> writes:
> 
> > My patch, on the other hand, is to deal with 'ls' output in case a file has
> > certain filesystem extended attributes.  These could be e.g. POSIX ACLs, or a
> > SELinux security context, or perhaps others.  If such an extended attribute is
> > present, 'ls -l' will print permissions with a '+' appended, e.g.
> > -rw-r--r--+
> > Instead of
> > -rw-r--r--
> > ...
> > For what it's worth, I've experienced this failure on my Ubuntu 8.04 laptop
> > with SELinux permissive mode, so it's possible ls behaves slightly differently
> > on other systems; I've not been able to determine this one way or another.
> 
> Is there way to explicitly tell "ls -l" not to do this, I have to wonder?

I looked through all the options to ls several times, and there wasn't anything
which stood out to me.  The output format of ls is rather rigid.
 
> POSIX.1 says that the file mode written under the -l option is
> "%c%s%s%s%c" (where the first %c is for type, three %s are for owner,
> group and other perm, and the last %c is "optional alternate access method
> flag").  If there is no alternate or additional access control method
> associated with the file, the "optional alternate access method flag"
> would be a single SP, otherwise it would be a printable character.

My fault for not reading up more carefully.  In that case, yes, I agree that we
should be able to deal with any such flag character, which my patch does not
do.
 
> If we drop the default ACL from the trash directory like Matt's patch
> does, does a file created in there (i.e. the ones we check with /bin/ls)
> still have "alternate or additional access control method associated with"
> it?

Yes.  SELinux, in particular, associates a 'security context' with *every*
file, which is used in SELinux access control checks.  This is stored as a
filesystem extended attribute in the 'security.selinux' namespace, and one will
exist from the moment the file is created.

One could dream up other access control methods, such as a kernel module which
would deny access to any files with the string 'frob' in the filename, and
suppose that ls could be extended to recognise the presence of this module and
alter its display accordingly.  There is clearly no way to ensure that no
'alternate or additional access control method' is associated with a file,
since the POSIX.1 language is sufficiently general to allow for almost
anything.

> Somehow it feels wrong that you need your patch, but if you do, stripping
> only the trailing '+' as your patch does not look sufficient, either.
> Shouldn't we be stripping the last letter if the length of actual is
> longer than strlen("-rwxrwxrwx"), as any printable can come there?

I hope I've made the case for the necessity of a patch (if nothing else, t1301
fails 10/16 tests on my system without some sort of patch), and I'll happily
agree that stripping any printable is a better choice.  Thanks for the
feedback; FWIW, your suggested patch here is

Tested-by: Deskin Miller <deskinm@umich.edu>

>  t/t1301-shared-repo.sh |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git c/t/t1301-shared-repo.sh i/t/t1301-shared-repo.sh
> index 2275caa..653362b 100755
> --- c/t/t1301-shared-repo.sh
> +++ i/t/t1301-shared-repo.sh
> @@ -20,6 +20,10 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
>  	test $ret != "0"
>  '
>  
> +modebits () {
> +	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
> +}
> +
>  for u in 002 022
>  do
>  	test_expect_success "shared=1 does not clear bits preset by umask $u" '
> @@ -85,8 +89,7 @@ do
>  
>  		rm -f .git/info/refs &&
>  		git update-server-info &&
> -		actual="$(ls -l .git/info/refs)" &&
> -		actual=${actual%% *} &&
> +		actual="$(modebits .git/info/refs)" &&
>  		test "x$actual" = "x-$y" || {
>  			ls -lt .git/info
>  			false
> @@ -98,8 +101,7 @@ do
>  
>  		rm -f .git/info/refs &&
>  		git update-server-info &&
> -		actual="$(ls -l .git/info/refs)" &&
> -		actual=${actual%% *} &&
> +		actual="$(modebits .git/info/refs)" &&
>  		test "x$actual" = "x-$x" || {
>  			ls -lt .git/info
>  			false
