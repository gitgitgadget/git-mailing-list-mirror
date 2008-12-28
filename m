From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT][PATCH] new: translate non word characters in patch name to '-'
Date: Sun, 28 Dec 2008 21:49:38 +0100
Message-ID: <20081228204938.GA13143@diana.vm.bytemark.co.uk>
References: <49562413.0437560a.287d.5133@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Hannes Eder <hannes@hanneseder.net>
X-From: git-owner@vger.kernel.org Sun Dec 28 21:51:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LH2bs-00038g-Jl
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 21:51:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbYL1UuR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Dec 2008 15:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbYL1UuR
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 15:50:17 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2423 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbYL1UuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 15:50:15 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1LH2Zu-0004mL-00; Sun, 28 Dec 2008 20:49:38 +0000
Content-Disposition: inline
In-Reply-To: <49562413.0437560a.287d.5133@mx.google.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104059>

On 2008-12-27 13:37:20 +0100, Hannes Eder wrote:

> This allows following usage:
>
> $ stg new full/path/file-fix-foobar
> Now at patch "full-path-file-fix-foobar"
>
> Signed-off-by: Hannes Eder <hannes@hanneseder.net>
> ---
>
> I ran into as a '/' in a patch messed up stgit.
>
> I find this useful as 'stg uncommit' does the same translation.

Clearly, bad path names shouldn't mess anything up -- see

  https://gna.org/bugs/?10919

But I would prefer "stg new" to quit with an error message when given
an illegal patch name, not silently mangle it. (Of course, the
commands that generate patch names from commit messages -- such as
"stg new" when not given an explicit patch name -- should mangle the
commit message as much as necessary. But when the user gives us a
patch name, we should either use that as is or fail with an
informative message.)

I think the right thing to do would be to construct a function that
validates patch names (I don't think we have one right now), and then
call it whenever we need to check if a patch name is OK. Such as when
the user gives us the name of a new patch. And when we've
auto-generated a patch name from a commit message, we should probably
assert that that the check function is OK with the name.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
