From: Kristian Amlie <kristian.amlie@trolltech.com>
Subject: Re: Honoring a checked out gitattributes file
Date: Wed, 28 Jan 2009 18:25:13 +0100
Message-ID: <498094F9.5070201@trolltech.com>
References: <498078F1.20807@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Cc: git <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 18:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSEBh-0001Ah-UM
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 18:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbZA1RZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 12:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbZA1RZ1
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 12:25:27 -0500
Received: from hoat.troll.no ([62.70.27.150]:46865 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbZA1RZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 12:25:26 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 134E020F7D;
	Wed, 28 Jan 2009 18:25:21 +0100 (CET)
Received: from sx01.troll.no (sx01.troll.no [62.70.27.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 0822420F6C;
	Wed, 28 Jan 2009 18:25:21 +0100 (CET)
Received: from sx01.troll.no (localhost.localdomain [127.0.0.1])
	by sx01.troll.no (8.13.8/8.13.8) with ESMTP id n0SHPJwo002070;
	Wed, 28 Jan 2009 18:25:20 +0100
Received: from [172.24.90.99] ( [172.24.90.99])
    by sx01.troll.no (Scalix SMTP Relay 11.4.1.11929)
    via ESMTP; Wed, 28 Jan 2009 18:25:17 +0100 (CET)
In-Reply-To: <49808B53.6040907@drmicha.warpmail.net>
References: <49808B53.6040907@drmicha.warpmail.net>
x-scalix-Hops: 1
User-Agent: Thunderbird 2.0.0.19 (X11/20090122)
X-Enigmail-Version: 0.95.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107552>

Michael J Gruber wrote:
> I think there's a general time ordering problem. Say you do the
> following commits:
> 
> A: add a.txt
> B: add a .gitattributes file covering *.txt (say with crlf or any filter)
> C: add c.txt
> 
> Now, with an empty dir, you do either
> 
> 1) checkout A, B, C sequentially
> 2) checkout C
> 
> The contents of the checkout will be different in cases 1) and 2):
> 1) a.txt is checked out out as is, c.txt according to the attributes
> 2) with current git: probably like 1), with your suggestion: both a.txt
> and c.txt filtered according to the attributes.
> 
> If you add a file and .gitattributes covering it in the same commit
> there is an ordering ambiguity which can be solved (patched away)
> easily, but I think the difference between 1) and 2) is still
> problematic, and would need to be dealt with.

I agree.

> 
> The main problem seems to be that changing a file like gitattributes can
> potentially change (by changing filters) the contents which should be
> stored for a different file even if the checkout of that file doesn't
> change.

Yes, that is a problem. Ideally, the crlf attribute would be tied to the
file entry itself rather than a separate file (so changing the attribute
would mean a change to the file), but I guess we are stuck with what we
have.

I still think that case 2) is the most common, and fixing it has the
appealing property that if the repository line endings are broken for
some reason (because of case 1 or something else), then recloning or
checking out from scratch is guaranteed to bring the working tree into
the "correct" state.

Since fixing both cases is a pretty big task and fixing only case 2 is
small, I propose that we go ahead with that.

--
Kristian Amlie
