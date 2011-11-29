From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Git Submodule Problem - Bug?
Date: Tue, 29 Nov 2011 18:42:03 +0100
Message-ID: <4ED5196B.5030200@web.de>
References: <38AE3033-6902-48AA-819B-DB4083F1F8EF@gmail.com> <201111291024.01230.trast@student.ethz.ch> <20111129101546.GB2829@kolya> <201111291125.41943.trast@student.ethz.ch> <20111129104105.GA10839@kolya>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Manuel Koller <koller.manuel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 18:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVRhU-0004il-2u
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 18:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab1K2Rmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 12:42:31 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:35656 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194Ab1K2Rmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 12:42:31 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate02.web.de (Postfix) with ESMTP id A99C31BB0FB52
	for <git@vger.kernel.org>; Tue, 29 Nov 2011 18:42:29 +0100 (CET)
Received: from [192.168.178.25] ([80.187.96.31]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0LdVdS-1R5lud0J9e-00iSVP; Tue, 29 Nov 2011 18:42:28
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <20111129104105.GA10839@kolya>
X-Provags-ID: V02:K0:LbYUcRes35z2PmUxVjXifWR0caAHue099kbTZQXI5w7
 ns+/RYkLqLcAyVTiYMEtpwzwP8KQFGiHGWsZNflHFUcXqZepn5
 zG6A5xBJg9jvzwBC2mrfLQyHRbLo78oU20lTAg1uyi1At7f2il
 UO3Oir+MoL9eygY3xEZuIwCkRJyY8WOggotWqG/kXzueOHKUw+
 FFmsHfUj7mCrYkW7QJpkw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186066>

Am 29.11.2011 11:41, schrieb Fredrik Gustafsson:
> On Tue, Nov 29, 2011 at 11:25:41AM +0100, Thomas Rast wrote:
>> So maybe the right questions to ask would be: what's the *official*
>> way of removing a submodule completely?  Do we support overwriting
>> submodules in the way Manuel wanted to?  Why not? :-)
> 
> I suggest that we add a command for that;
> git submodule remove <submodule>

Hmm, to me it looks like the problem is in "git submodule add". It
doesn't check if the submodule repo it finds in .git/modules matches
the one the user wants to create. So we end up reviving the first
submodule although the user wants to use a completely different repo.

One solution could be to only let "git submodule update" revive
submodules from .git/modules and make "git submodule add" error out
if it finds the git directory of a submodule with the same name in
.git/modules. But currently there is no way to tell "git submodule add"
to use a different submodule name (it always uses the path as a name),
so we might have to add an option to do that and tell the user in the
error message how he can add a different submodule under the same
path.

Another solution could be that "git submodule add" detects that a
submodule with the name "sub" did exist and chooses a different name
(say "sub2") for the the new one. Then the user wouldn't have to
cope with the problem himself.
