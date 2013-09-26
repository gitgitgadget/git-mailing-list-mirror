From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/10] pack v4 UI support
Date: Thu, 26 Sep 2013 12:09:49 +0700
Message-ID: <CACsJy8De9mMvSpnzHuq+XG+Pfi5QD1fY44uHT8hNQZN6sU-hgg@mail.gmail.com>
References: <1380162409-18224-1-git-send-email-pclouds@gmail.com> <alpine.LFD.2.03.1309260031290.312@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Sep 26 07:10:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP3qP-0006JW-Dc
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 07:10:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab3IZFKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 01:10:23 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:65001 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab3IZFKW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 01:10:22 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so1333793obc.10
        for <git@vger.kernel.org>; Wed, 25 Sep 2013 22:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=awfsC3nq+Hs2GQ8+0Vsnyv9ACUsZ99/wRntE49bSTjU=;
        b=yHKzSWYpZS4xEKicuAmTSsy6XsiziVrsfIwcZ3TqmP1R5O0Id2wFvBsMClKEVw3yHp
         sn46mOMueGX+NdTG/jjiYGKagf0z07YZejY+P9q1No8V/JT28hQOac+8tgEuWoLbeMr0
         zxtqjNTV+CSHWqcOL61+UmRDlkGEdTuIgrgT2s35DguJCGT6//bFcbHBEceoMeoQ3HrW
         mw1ZbkdnBz5h6QtzpBRI2xv/ZHw1RpX0l45D7GQ39NO5c8bHg0U9FApF0JnYqOQM4bV6
         egkjroqTsrE0ICy208aiRWd1NJBt6YRdcMt6EZIF0VAHmlf52o1GbTKPw9NafJPSKrAx
         +VCQ==
X-Received: by 10.182.225.129 with SMTP id rk1mr3284obc.73.1380172221260; Wed,
 25 Sep 2013 22:10:21 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 25 Sep 2013 22:09:49 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1309260031290.312@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235400>

On Thu, Sep 26, 2013 at 11:51 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> Multi-base tree support is not part of "packv4" capability. Let's see
>> if such support comes before the series is merged to master. If so we
>> can drop that line from protocol-capabilities.txt. Otherwise a new
>> capability can be added for multi-base trees.
>
> What is that for?  Multi-base trees are not created yet, but the code to
> parse them is already there.  So I don't see the point of having a
> capability in the protocol for this.

pv4_get_tree() can. index-pack cannot.

>> Another capability could be added for sending the actual number of
>> objects in a thin pack for more accurate display in index-pack. Low
>> priority in my opinion.
>
> That just cannot be communicated during capability exchange.  This
> number is known only after object enumeration.  Hence my suggestion of a
> ['T', 'H', 'I', 'N', htonl(<number_of_sent_objects>)] special header
> prepended to the actual pack on the wire.  And that has to be decided
> before formalizing the pack v4 capability.  That makes it a somewhat
> higher priority.

The capability is to let the server know the client understands ['T',
'H', 'I', 'N' ..]. The server can choose not to send it later, but
that's ok. Hence the new capability. I'm somewhat reluctant to do it
because of peeking code in fetch-pack and receive-pack and some
refactoring may be needed first. But I could certainly put it on
higher priority.
-- 
Duy
