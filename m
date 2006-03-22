From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cloning from sites with 404 overridden
Date: Tue, 21 Mar 2006 22:47:16 -0800
Message-ID: <7v1wwvascr.fsf@assigned-by-dhcp.cox.net>
References: <20060322025921.1722.qmail@science.horizon.com>
	<e5bfff550603212206k1924d352xcbdb0e5a11b88a50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 07:48:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLx93-0001Vc-R9
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 07:48:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750968AbWCVGrx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 01:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWCVGre
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 01:47:34 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28630 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750968AbWCVGrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 01:47:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322064301.VJHH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 01:43:01 -0500
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603212206k1924d352xcbdb0e5a11b88a50@mail.gmail.com>
	(Marco Costalba's message of "Wed, 22 Mar 2006 07:06:13 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17808>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Perhaps I am proposing a total idiocy, I don't know git-fetch
> internals, but wouldn't be better to avoid trying to download a non
> existing object? So to fix the problem at the origin?
>
> I don't know if it is possible to list contents before try to download
> so to avoid asking for a non existing object.

There is no way for the downloader to know if the upstream
repository has packed which object.  What is happening is that
the commit walker asks for loose object first because it does
not know.  Upon getting a "no such file" (or in the case of
misconfigured HTTP server that does not say 404, "corrupt
object"), it then checks if the object appears in the pack by
downloading the pack index.  It can tell what objects are in the
packs by looking at the pack index and downloads the pack that
contains needed object.
