From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Tue, 19 Mar 2013 12:06:24 -0700
Message-ID: <20130319190624.GB3655@google.com>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
 <20130319034822.GL5062@elie.Belkin>
 <vpq1ubb3o5g.fsf@grenoble-inp.fr>
 <7v620nl99g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 20:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI1s9-0007am-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 20:06:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab3CSTGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 15:06:30 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:37019 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005Ab3CSTG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 15:06:29 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so680939pbc.36
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 12:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3iVPOxutD1QkOAL5ny21XqnSex++pCNtpmdHXDtT8VM=;
        b=veNK42BdhsRPahVxzQquwdkTH6q9o/nGpQmvba7MO8WPk55coH4CHE2l2pZEO1eUct
         Dx93KK5PWsVOfgt62cB4kiRXxXOLrumtz5UCF1el7qCjNCcB5BO8F8kiAX5l0Ti/3nRV
         83NJFFEEDWK/1grvmVkReASUQGhkFdb8yaRDN6msxpXD3T501XzR0PJBtbRn1AJ5TxOz
         mZWTfRVV6oWLfqE7/cJzrbkxYIIPIplGGv0kQzoh0Zad2RVZ2Qv0a1alQar6+o2EXzQq
         hVnXoqPBBlVwvW83EM4a0KJ6rNWPdqY7DfF9NA0rtiP+WFB9B5aKROETnWo/OjIY56it
         DjgA==
X-Received: by 10.66.190.104 with SMTP id gp8mr5053121pac.84.1363719989417;
        Tue, 19 Mar 2013 12:06:29 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id vd4sm25258037pbc.35.2013.03.19.12.06.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 12:06:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v620nl99g.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218549>

Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> No time to review the code now. I thought about implementing something
>> like that, but did not do it because I didn't want the change in the
>> code to be too big. At some point, we'll have to remove the warning and
>> it's easier with my version than with yours. But the "damage" to the
>> code do not seem too big, so that's probably OK and will actually reduce
>> the pain for some users.
>
> Getting these warnings is a *good* thing.
>
> You may happen to have no changed path outside the current directory
> with this particular invocation of "git add -u", or you may do, or
> you may not *even* remember if you touched the paths outside.
>
> Training your fingers to type "git add -u ." without having to even
> think, is primarily to help the last case.

The problem is that these warnings are triggering way too often.  It
is like the story of the boy who cried "wolf": instead of training
people to type "git add -u .", we are training them to ignore
warnings.

I personally often find myself in the following situation:

	$ cd repowithdeepsubdirs/third_party/git
	$ ... hack hack hack ...
	$ git add -u

The result is a pile of warning text that I cannot convince myself not
to ignore because I already *knew* that the only changes present were
under the cwd.  The old and new "git add -u" behaviors always have the
same effect in this case, so the warning is not relevant to me.  So I
find myself being trained to ignore the warning.

Presumably habitual Java hackers that do their work in a
com/long/package/name subdirectory of the toplevel would find this
even more annoying.

One important exception is that if "git add -u :/" is slow, users need
to learn to run "git add -u ." to speed the operation up.  But I think
that is intuitive already.  Running a full-tree diff which slows down
the code that decides whether to print a warning is a good way to
train people regarding how long to expect a plain "git add -u" to
take.

Hoping that clarifies,
Jonathan
