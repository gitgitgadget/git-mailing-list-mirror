From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/10] bisect: automatically sort sha1_array if needed when looking it up
Date: Sun, 10 May 2009 06:44:14 +0200
Message-ID: <200905100644.14786.chriscool@tuxfamily.org>
References: <20090509154419.5324.96204.chriscool@tuxfamily.org> <20090509155548.5387.70784.chriscool@tuxfamily.org> <m3ljp6me9v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 06:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M30xh-0002Nr-Ku
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 06:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbZEJEp4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 May 2009 00:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbZEJEpz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 00:45:55 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:33845 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbZEJEpz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 May 2009 00:45:55 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 8E448940051;
	Sun, 10 May 2009 06:45:48 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 5FFCE940002;
	Sun, 10 May 2009 06:45:46 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <m3ljp6me9v.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118704>

Le samedi 9 mai 2009, Jakub Narebski a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This makes sha1_array easier to use, so later patches will be simpl=
er.
>
> Hmmm... sort on lookup array. I wonder if it would be worth
> librarizing, and if there is any smart optimization for that (like
> e.g. heap for fast access to smallest value and fast insertion, using
> insertion sort for almost sorted array, etc.).
>
> BTW. does it become unsorted anywhere?

No, it doesn't. We first read all the "refs/bisect/good-*"=20
and "refs/bisect/skip-*" and put them in some "struct sha1_array".
Then later we may lookup sha1 there from 2 different functions:
"check_merge_bases" first and then "filter_skipped".

This patch optimizes by not sorting before we lookup, so if we don't lo=
okup=20
anything, we pay no sorting price.

Best regards,
Christian.
