From: Johan Herland <johan@herland.net>
Subject: Re: RFC: Make git bisect submodule aware.
Date: Wed, 9 Jun 2010 16:57:21 +0200
Message-ID: <201006091657.21735.johan@herland.net>
References: <6AC4E373-C28F-455E-93A6-6FA5A57723A2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Michalske <smichalske@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 16:57:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMMir-0001jm-GT
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 16:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757760Ab0FIO52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 10:57:28 -0400
Received: from smtp.opera.com ([213.236.208.81]:33140 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757738Ab0FIO52 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 10:57:28 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o59EvLma031186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Jun 2010 14:57:22 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <6AC4E373-C28F-455E-93A6-6FA5A57723A2@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148782>

On Wednesday 09 June 2010, Steven Michalske wrote:
> When git bisect discovers that the change set that creates the
> failure also contains a submodule change, that submodule should then
> be bisected starting with the good super modules code and working to
> a break in the sub module.  If the change contains submodule change
> and super code changes than the bisection gets trickier, so we need
> some ideas on how to solve that search.
>
> Example:
>
> Super: A-B-C-D-E
> Sub:   s-s-y-y-z
>
> Where s is not required to be a parent of y,  meaning that there
> might be 300 commits or just 1 between s and y in the submodule or
> they are disjoint then the bisecting should happen both routes into
> the submodule.
>
> [...]

My general feeling about this scenario is that 'git bisect' should not 
automatically descend into submodules and continue bisecting there.

As you observe, there may be weird co-dependencies between the 
superproject and the submodule (or even between different submodules), 
so the safest default in this situation is for 'git bisect' to simply 
bail out.

Then the user can at his/her leisure figure out if the best way to 
proceed is indeed a nested 'git bisect' in the submodule, and if so, 
which is the most appropriate version of the superproject (or other 
submodules) to use for this nested bisect.

Trying to make Git too "clever" about these things is likely to come 
back and bite us in the ass.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
