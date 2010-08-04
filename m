From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the replaced one
Date: Wed, 4 Aug 2010 13:58:12 +0200
Message-ID: <201008041358.13081.chriscool@tuxfamily.org>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com> <201008030700.40533.chriscool@tuxfamily.org> <AANLkTikaPhV+SkzCJ+G3V39mS4FORELP34ePrPWbHFeV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 13:58:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogcc8-0004gX-2M
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 13:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117Ab0HDL6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 07:58:23 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:47413 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757476Ab0HDL6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 07:58:22 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id ECDC6818094;
	Wed,  4 Aug 2010 13:58:14 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTikaPhV+SkzCJ+G3V39mS4FORELP34ePrPWbHFeV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152574>

On Tuesday 03 August 2010 08:01:32 Nguyen Thai Ngoc Duy wrote:
> On Tue, Aug 3, 2010 at 3:00 PM, Christian Couder
> 
> <chriscool@tuxfamily.org> wrote:
> >> With parse_object(A), I get an object pointer whose sha1 is B.
> >> 
> >> With  lookup_commit(A), I get an object pointer whose sha1 is A.
> > 
> > Maybe there is a bug somewhere and you should get an object pointer whose
> > sha1 is B or maybe the content of the object that was inserted in the
> > lookup table should have been the content from A and not from B.

After having another look at that, I think the content of the object in the 
lookup table should be the content of A. It should be a bug if the object 
returned by lookup_commit(A) does not have the content of A.

> > I will
> > try to have a deeper look at that, but it would help if you could give
> > an example of a command that triggers this behavior.
> 
> The following patch add "sha1" command. These commands give different sha1:
> 
> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` A
> git sha1 `git rev-parse HEAD` `git rev-parse HEAD^` B

Yes, but that does not mean that the content of the object returned by 
lookup_commit(A) is not the content of A.

Or do you have an example where the content of the object returned by 
lookup_commit(A) is not the content of A?

I mean that we  should always be consistent by having objects with an
obj->sha1 field corresponding to the content.

So yes we have:

> With parse_object(A), I get an object pointer whose sha1 is B.
>
> With  lookup_commit(A), I get an object pointer whose sha1 is A.

but it's not a problem, it's just the result from the fact that parse_object() 
(completely) replace objects and lookup_commit() does not.

Best regards,
Christian.
