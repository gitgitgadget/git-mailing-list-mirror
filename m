From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule and --upload-pack
Date: Mon, 31 Aug 2009 16:51:31 -0700
Message-ID: <7vk50jtud8.fsf@alter.siamese.dyndns.org>
References: <9D7140EC-EAFD-4408-93E3-0E756BA363DA@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giulio Eulisse <Giulio.Eulisse@cern.ch>
X-From: git-owner@vger.kernel.org Tue Sep 01 01:51:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiGf8-0006Pj-9o
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 01:51:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752263AbZHaXvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 19:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752233AbZHaXvk
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 19:51:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZHaXvh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 19:51:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D7C583E39B;
	Mon, 31 Aug 2009 19:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=lwG3SJ/uhiERw/tYnJgxRaQtR60=; b=YomyUbHC1x/WKgN0q7V+Msw
	XbJFemkYeGJ52wMA/kWgdnv34nAPZRCJlu2ZFH+uXVEGXs1vvUwU58MtLJzPetwi
	094jXTLn1ahUkXH45011sisyuUxRctdu325XIYvXwIMZ0CO34AFQ65+/cHF7deKE
	mCrABVd0+J5ILXqUEaY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=XijtITVGRNCginYrhn2njQaBm/ZFKWtOxIO/SfvS21jVRr2OF
	PZx05hdAPWBAHQHFEcmdErrAO6qxB7NzaIx0QJajIEBx57y2lec5yO188Z2+q1qW
	nFDg8lj6571ji4Z6+CYdC0475KuJcpUdAmKYy3XU03pEGSyOhc4NPQZiFU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BC10E3E39A;
	Mon, 31 Aug 2009 19:51:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5D3953E397; Mon, 31 Aug 2009
 19:51:33 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38E96938-9689-11DE-972B-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127510>

Giulio Eulisse <Giulio.Eulisse@cern.ch> writes:

> There was a thread a while ago aboyt having --upload-pack support for
> git-submodule.
>
> Given that there was no followup (as far as I can tell) and I needed
> pretty much
> the same functionality I ported Jason's patch to work on top of 1.6.4.2.

Thanks.

Can you point at the original patch with a usable commit log message, in
the gmane archive (i.e. http://thread.gmane.org/...) if possible?  I
do not think we have that patch queued anywhere even in 'pu'.

Given that it looks like a new feature, I do not think it would be
appropriate for any of the future 1.6.4.X series, but if it is useful we
may want to have it in the upcoming 1.6.5 release.

> Comments?

See below.

> diff --git a/Documentation/git-submodule.txt b/Documentation/git- 
> submodule.txt

The patch is linewrapped and will not be applicable.  But I'll comment on
the contents to save a round-trip.

> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
> index 5daf750..bf982a6 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -30,6 +30,14 @@ submodule.<name>.path::
>  submodule.<name>.url::
>  	Defines an url from where the submodule repository can be cloned.
>
> +submodule.<name>.receivepack::
> +	The default program to execute on the remote side when pushing.  See
> +	option \--receive-pack of linkgit:git-push[1].
> +
> +submodule.<name>.uploadpack::
> +	The default program to execute on the remote side when fetching.  See
> +	option \--upload-pack of linkgit:git-fetch-pack[1].

This placement of description in the documentation and variables in the
namespace quite sane, as these are properties of the remote site, and they
belong together with submodule.<name>.url.

> @@ -53,12 +60,16 @@ Consider the following .gitmodules file:
>
>  	[submodule "libbar"]
>  		path = include/bar
> -		url = git://bar.com/git/lib.git
> +		url = ssh://bar.com/~/git/lib.git
> +		uploadpack = /home/you/bin/git-upload-pack-wrapper
> +		receivepack = /home/you/bin/git-receive-pack-wrapper
> ...
> +For `libbar`, packs are retrieved and stored via the upload and receive
> +wrappers, respectively.

Using a custom wrapper in this example feels very misleading.  The option
is primarily meant as a workaround for a broken or hard-to-modify sshd
settings that does not allow you to include the directory you installed
upload-pack/receive-pack to the PATH environment when the ssh session is
not interactive.

> @@ -97,13 +99,30 @@ module_clone()
>  	test -e "$path" &&
>  	die "A file already exist at path '$path'"
>
> +        uploadpackCmd=""
> +
> +        if test "$uploadpack"
> +        then
> +          uploadpackCmd="--upload-pack $uploadpack"

Can the value of uploadpack contain a shell IFS?  This is a rhetorical
question---read on.

> +        fi
> +
>  	if test -n "$reference"
>  	then
> -		git-clone "$reference" -n "$url" "$path"
> +		git-clone $uploadpackCmd "$reference" -n "$url" "$path"

Without using uploadpackCmd and risking to trash IFS characters in the
variable, you can do something like:

    git clone ${uploadpack+--upload-pack "$uploadpack"} ...

I would prefer the code not to set variable "uploadpack" when nothing is
specified, instead of setting it to an empty string like this patch does,
but if you are going to use an empty string as a signal that no uploadpack
is specified, then you would need a colon between 'k'and '+' in the above.

> @@ -738,6 +801,18 @@ cmd_sync()
>  			remote=$(get_default_remote)
>  			say "Synchronizing submodule url for '$name'"
>  			git config remote."$remote".url "$url"
> +			uploadpack=$(git config -f .gitmodules submodule."$name".uploadpack)
> +			receivepack=$(git config -f .gitmodules
> submodule."$name".receivepack)
> +			if test "$uploadpack"
> +			then
> +			    git config submodule."$name".uploadpack "$uploadpack" ||
> +			    echo "  Warn: Failed to set uploadpack for
> $url' in submodule  path '$name'."
> +			fi
> +			if test "$receivepack"
> +			then
> +			    git config submodule."$name".receivepack "$receivepack" ||
> +			    echo "  Warn: Failed to set receivepack
> for '$url' in  submodule path '$name'."
> +			fi
>  		)

I do not agree with this part, nor what the "cmd_init" does.

Having URL/uploadpack/receivepack 3-tuple in the tracked .gitmodules is
sensible, as that is how the project expresses its recommendations to
people who clone the toplevel project.

However, after the top-level project is cloned and the submodules are
populated in the work tree of the person who cloned, I think these values
should be propagated to $path/.git/config, i.e. the configuration file of
the submodule checkout.

Inside cmd_update(), there is this code snippet:

	if test -z "$nofetch"
	then
		(unset GIT_DIR; cd "$path" &&
			git-fetch) ||
		die "Unable to fetch in submodule path '$path'"
	fi

And the patch does not touch it.  For this git-fetch to honour the custom
uploadpack your user configured, remote.origin.uploadpack variable in the
configuration file of the submodule checkout needs to be updated, because
this fetch will not (and should not) look at the configuration file of the
superproject.

You _could_ also copy them to submodule.$name.$var of the top-level
project if you really wanted to, but I do not think doing so serves any
useful purpose.
