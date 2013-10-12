From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [BAD PATCH 0/9] v4-aware tree walker API
Date: Sat, 12 Oct 2013 22:59:24 +0700
Message-ID: <CACsJy8DZvdWyKSvLzPhS7OqKUU-OKG40M7M1HxN4eADsx0od6Q@mail.gmail.com>
References: <1381329976-32082-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.03.1310091137310.3023@syhkavp.arg> <20131011122259.GA7776@lanh>
 <20131011130528.GA10014@lanh> <alpine.LFD.2.03.1310121001000.3023@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Oct 12 18:00:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV1cA-0003DY-BJ
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 18:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566Ab3JLQAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 12:00:17 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:44565 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab3JLP7y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 11:59:54 -0400
Received: by mail-oa0-f54.google.com with SMTP id n5so3364931oag.13
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 08:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ze69DzIoRvMRZKHrMzxP+dkfeYpLxBroAQvUFcJdC8w=;
        b=tJPjb8ssFVXoLCuQTK+shlfG1XTmKbVGJxl6PEerAQlGQOGEUMjFIJWstVuMNv2p+w
         otIcalz0pZ92oK6NUDDGQhcMxJvLjG+XkyUaI4/Bzrt5gHG9f2Ei1gqqS6YVgxiR7nKR
         tUDMmcKyu1MSVPO3UOyiTIcpeT/FWn+KQ3tDCgQW7JHkzh53Q3rAnESVJqO1nNYdbGRF
         goDJMz3Ulu0PtZhUsRVgOdpDEqFXNg0IM1uaejverMo0aF+7ndbhCFv/u9P0d+K96Avs
         uouabe+J4iwu36e+MyO+6Ijvg5B2W2XcUcHY7WzGToZwVDgm+7jK4n1Ass2OH7yWFCxR
         89Lw==
X-Received: by 10.60.63.68 with SMTP id e4mr19440802oes.23.1381593594097; Sat,
 12 Oct 2013 08:59:54 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Sat, 12 Oct 2013 08:59:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1310121001000.3023@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236051>

On Sat, Oct 12, 2013 at 9:42 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 11 Oct 2013, Duy Nguyen wrote:
>
>> On Fri, Oct 11, 2013 at 07:22:59PM +0700, Duy Nguyen wrote:
>> > > > Maybe we could make an exception and allow the tree walker to pass
>> > > > pv4_tree_cache* directly to decode_entries so it does not need to do
>> > > > the first lookup every time..
>> > > >
>> > > > Suggestions?
>>
>> Looking at decode_entries() traces I think the "one decode_entries()
>> for one tree_entry()" just amplifies the delta chain effect. If you
>> hide 3 entries behind 5 layers of copy sequences
>> (i.e. tree1->tree2->..->tree5->real-tree-entry), then every
>> decode_entries(count=1) will have to go through 5 layers.
>
> Calling decode_entries() for every tree entry is a bad approach.  We
> should really implement this as a state machine preserving the entire
> state between entries so that moving to the next entry is just a matter
> of advancing a pointer in most cases.

Yeah. Maybe first step is avoid recursion in decode_entries(). We need
to do that eventually to avoid stack overlow due to long depths.
-- 
Duy
