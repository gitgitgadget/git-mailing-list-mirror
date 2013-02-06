From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 6 Feb 2013 11:45:43 -0800
Message-ID: <20130206194542.GB21003@google.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu>
 <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:46:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Awh-0003Yi-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 20:46:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757925Ab3BFTpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 14:45:51 -0500
Received: from mail-oa0-f49.google.com ([209.85.219.49]:39086 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756226Ab3BFTpv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 14:45:51 -0500
Received: by mail-oa0-f49.google.com with SMTP id j6so1913195oag.22
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 11:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=z2qr6Org8VZpYP8/ERl1rK5pbfR+Fs+oxaDtMdZWtHk=;
        b=FTrlQ/enKunt4Gt4gLTJVqtxlm1w6O1Vy/gPVxfAMpANCKJepoajI9RHv1ezUEeyiG
         LCasum7Oz3N1GDIRD77fa8evqc/PPsd3USgK2lwruQlmDSAXry+XLreVdYJ6lmJzMNWl
         OLsDxsSMnsSkCuIjjD03Ks8SJOQqDa9ayezPTbAdiX+gdIt1kWR8laJqx6+AnUJn59li
         TdoF2mJ+FUaGRUJxLyqYu9g/cUdHl2UxDdngWKFg75xlYUafrzCte4kCrcg/TuDlRvpG
         zUQ4rC4FauqeTvbZ4ChI9uOYXCF5/khsEODB/UHvlzNOs6xfCdXsN4/MPSac+UWagvSK
         JBQg==
X-Received: by 10.182.113.40 with SMTP id iv8mr16196398obb.12.1360179950517;
        Wed, 06 Feb 2013 11:45:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id q4sm39975160paz.20.2013.02.06.11.45.48
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 11:45:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215627>

Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>> On Tue, Feb 5, 2013 at 5:29 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:

>>> Hiderefs creates a "dark" corner of a remote git repo
[...]
>> Or you can think hiderefs is the first step to addressing the
>> initial ref advertisment problem.  The series says hidden refs are
>> to be fetched out of band, but that's not the only way.
>
> Let me help unconfuse this thread.
>
> I think the series as 8-patch series was poorly presented, and
> separating it into two will help understanding what they are about.
>
> The first three:
>
>   upload-pack: share more code
>   upload-pack: simplify request validation
>   upload/receive-pack: allow hiding ref hierarchies
>
> is _the_ topic of the series.  As far as I am concerned (I am not
> speaking for Gerrit users, but am speaking as the Git maintainer),
> the topic is solely about uncluttering.  There may be refs that the
> server end may need to keep for its operation, but that remote users
> have _no_ business knowing about.

An obvious question when looking at that alone is, is there ever
actually need for such private refs?  If the refs are not meant to be
shared with users *at all*, why are they even refs?

An answer is "because refs force gc to keep the corresponding
objects".  For example, the sysadmin may want to keep refs/archived/
refs for dead branches that should not be advertised or accessible to
the user any more.  Seems sane, though not especially exciting.

What is more exciting to me is that it is a first step toward
addressing the complicated problem of offering access to more refs
than can be efficiently presented in the current ref advertisement.  I
think that's a harder problem but something like this would be needed
in order to support existing clients without performance degredation.

And in the meantime, it helps with the refs/archived case.

Thanks for explaining.
Jonathan
