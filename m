From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] submodule: configure submodule.<name>.path on add and
 init
Date: Tue, 25 Sep 2012 22:58:43 +0200
Message-ID: <50621B03.6010805@web.de>
References: <1348515040-19986-1-git-send-email-orgads@gmail.com> <5060BB3D.9010609@web.de> <7vmx0fxicf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Orgad Shaneh <orgads@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 22:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGcEL-0000J6-B9
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 22:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757225Ab2IYU6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 16:58:51 -0400
Received: from mout.web.de ([212.227.15.3]:59852 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754399Ab2IYU6u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 16:58:50 -0400
Received: from [192.168.178.41] ([91.3.171.242]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LZeZU-1TkTve0aPE-00lRVk; Tue, 25 Sep 2012 22:58:46
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <7vmx0fxicf.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:d/miRZD/va17n5UzY9qVmO552YFQhAL8FkEUO0koAyD
 VQiop4Tt4lk1bSuF5dcBx8/nVBIc8Fgsezc8CF5a5wkwaJmeRv
 WH73T0vBoKfyIACNTZjqNWmPiQ05CPFQV1QVCtKexiMlCSh0Su
 vXBQ2ukhDFaCvDQX/wlvR94apl2yH6XQFwDBiqeDqZ3YVbENuU
 SrpJIyHMWBJ1l4wa/mc7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206377>

Am 24.09.2012 22:43, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 24.09.2012 21:30, schrieb Orgad Shaneh:
>>> In order to read diff options for a submodule, its path must be configured
>>> ---
>>>  git-submodule.sh |    2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/git-submodule.sh b/git-submodule.sh
>>> index 3e2045e..f97bb62 100755
>>> --- a/git-submodule.sh
>>> +++ b/git-submodule.sh
>>> @@ -359,6 +359,7 @@ Use -f if you really want to add it." >&2
>>>  			esac
>>>  		) || die "$(eval_gettext "Unable to checkout submodule '\$sm_path'")"
>>>  	fi
>>> +	git config submodule."$sm_path".path "$sm_path"
>>>  	git config submodule."$sm_path".url "$realrepo"
>>>  
>>>  	git add $force "$sm_path" ||
>>> @@ -476,6 +477,7 @@ cmd_init()
>>>  				url=$(resolve_relative_url "$url") || exit
>>>  				;;
>>>  			esac
>>> +			git config submodule."$name".path "$name" ||
>>>  			git config submodule."$name".url "$url" ||
>>>  			die "$(eval_gettext "Failed to register url for submodule path '\$sm_path'")"
>>
>> Nack. The path must only be configured in .gitmodules or we'll
>> never be able to rename the submodule directory.
> 
> That sounds sensible on the surface, and the rejection of this is
> probably the right thing to do, but then how would the name/path
> mapping work without .gitmodules?  Historically, you did not have to
> have a .gitmodules in-tree at all in order to use submodules
> locally, but if discovery of submodule.$name.ignore depends on
> having the in-tree .gitmodules file, that sounds like a minor
> regression to me.

AFAIK the name/path mapping was added to enable moving submodules
around in the work tree without having to adapt its $GITDIR/config
entries every time you checkout a commit where the submodule's work
tree is moved someplace else inside the superproject's work tree.
Nowadays we also use that to consistently store the submodule's
.git directory under "modules/<name>" inside the superproject's
.git directory no matter what its current path is.

You still don't need a .gitmodules file to use submodules locally,
but then moving around these submodules is not - and has never
been - that easy. To use the ignore setting without a .gitmodules
file you'll just have to set both submodule.$name.ignore and
submodule.$name.path (to provide the mapping, in most cases path
and name will simply be the same) in your $GITDIR/config and
everything will work just fine.
