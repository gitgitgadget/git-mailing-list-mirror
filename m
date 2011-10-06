From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 20:57:35 -0400
Message-ID: <CAG+J_DxXcvF3tBPkf7ZEtiXvEK80zYJvP1rNx-PagM8TV-1KSA@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
	<CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
	<7vpqib8jzk.fsf@alter.siamese.dyndns.org>
	<CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
	<7vzkhf713u.fsf@alter.siamese.dyndns.org>
	<CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
	<7vaa9f59p5.fsf@alter.siamese.dyndns.org>
	<CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
	<7vwrcj3sow.fsf@alter.siamese.dyndns.org>
	<CAG+J_DzZrFx2v09zNxKm2xyA82MyKRTq3AEus3QthtpZYhQn0A@mail.gmail.com>
	<7vsjn73q6j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 02:57:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBcHP-0007Pq-1l
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 02:57:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935618Ab1JFA5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 20:57:36 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63818 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935275Ab1JFA5f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 20:57:35 -0400
Received: by ywb5 with SMTP id 5so2134535ywb.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 17:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=K6GRFJpDPEmaq0nmokb0DJ5pg3E+f9FQmlE47DX21m4=;
        b=GbEPpG4/84lb2sdswp4QvpVB8JpwmEdx5qluEhkNMlqQmU14gYFSibxl0OW5hyUa2L
         l60EnJXdxy4xA/9lGWNDGfriuGAD3VXWjvs8wbP4S5eoUdSzqppVn1wZVcmWtaaAwqsc
         fndqqCpaH3pxeZ/EsdHXD1zIiikoelfApyv5s=
Received: by 10.236.76.102 with SMTP id a66mr497905yhe.25.1317862655161; Wed,
 05 Oct 2011 17:57:35 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 17:57:35 -0700 (PDT)
In-Reply-To: <7vsjn73q6j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182912>

On Wed, Oct 5, 2011 at 8:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Not at all. My build infrastructure determines where to install the built
> binary based on what branch is checked out. Having a head detached at a
> commit that is at the tip of one branch is not necessarily the same as
> having the branch actually checked out.

That's fair, but I'm willing to wager that's a minority use-case. Not
that it shouldn't be possible, but perhaps it should require telling
git that's really what you want to do with checkout --force.

>> Also, if we wait till commit time to tell the user "sorry, topic's
>> been updated elsewhere", now the user is in a perilous state.
>
> Wouldn't the "elsewhere" user would be warned before being able to update
> the branch? I thought the whole point of your adding "this branch is
> checked out over there" is exactly so that the "elsewhere" user can come
> talk to you before that happens. These two people might be yourself, of
> course.

So you're envisioning this?

  $ git commit foo.c
  Warning, master is also checked out in workdir2

How does that help the user? Now they have to go to workdir2 and reset
--hard. Is that really something we want to encourage?

And what if they do this:

  $ cd workdir1
  $ edit foo.c
  ... time passes...
  $ cd workdir2
  $ edit foo.c
  $ git commit foo.c
  Warning, master is also checked out in workdir1

j.
