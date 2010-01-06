From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: gc.auto bug in 1.6.5.7
Date: Wed, 06 Jan 2010 12:31:07 -0600
Message-ID: <u1EMnFha7hfr0SI0p8dEvAJML7vykSCAA6YzQd7klvze6oKChlMCLg@cipher.nrlssc.navy.mil>
References: <cccedfc61001060959h72a07eb6g78f2ca231867df63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Nelson <jnelson@jamponi.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 19:31:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSaf7-0007zV-Qz
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 19:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564Ab0AFSbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 13:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232Ab0AFSbM
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 13:31:12 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37116 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932285Ab0AFSbL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 13:31:11 -0500
Received: by mail.nrlssc.navy.mil id o06IV8DW012586; Wed, 6 Jan 2010 12:31:08 -0600
In-Reply-To: <cccedfc61001060959h72a07eb6g78f2ca231867df63@mail.gmail.com>
X-OriginalArrivalTime: 06 Jan 2010 18:31:08.0134 (UTC) FILETIME=[69CCB060:01CA8EFE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136285>

Jon Nelson wrote:
> It would appear that there is a bug in git, at least as of 1.6.5.7, in
> the gc command.
> When gc.auto is non-zero, it appears to consider packfiles as "loose"
> - this conflicts with pack.packSizeLimit, insofar as I have
> pack.packSizeLimit set to 2M (which appears to work).  If gc.auto is,
> say, 50 - once I exceed 50 2MB packs then gc --auto repacks *every
> single time* it is run. This is unexpected, at least.

There is also a gc.autopacklimit which controls auto-gc'ing based on
the number of packs.  The default is 50 and it does not consider the
pack.packSizeLimit setting when deciding whether or not to auto-gc.
It can be raised, or it can be disabled by setting it to zero.

The ideal number of packs is one, but if you limit the size of packs
to be very small, then you will quickly grow the number of packs.
Perhaps autogc should only count packs that are much smaller than
pack.packSizeLimit?  Looks like there is already a comment in
builtin-gc.c suggesting something similar.

-brandon
