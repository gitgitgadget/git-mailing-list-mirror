From: Eric Raible <raible@gmail.com>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Tue, 30 Jun 2009 14:22:43 -0700
Message-ID: <279b37b20906301422w2b895afai5edf42fcbfcc7d5a@mail.gmail.com>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com>
	 <20090630040337.GA23741@sigio.peff.net>
	 <279b37b20906301105tf92f471g6146a083ba2e2882@mail.gmail.com>
	 <20090630193135.GA4460@sigio.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 30 23:29:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLkta-00063I-Pv
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 23:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579AbZF3V33 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jun 2009 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbZF3V32
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 17:29:28 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:41206 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248AbZF3V32 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jun 2009 17:29:28 -0400
Received: by qw-out-2122.google.com with SMTP id 9so221152qwb.37
        for <git@vger.kernel.org>; Tue, 30 Jun 2009 14:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s5oIIuQ/xFni7P6N3i2Jnt84FBaeL9YTMFhNIlT+bCk=;
        b=Bp9eauo97mGPvGbwJXVYQjLb15/LPSp0ecIv8BPUroHNI+3ZfkcGigkGylVSlvHrId
         ruTI6TjNLc5uMgvF5GB6PIFZvqsn11z6PEHi8Iq7qC3GYzuee+a8pVrfn06TFXDiNsws
         dAicZs9oa6zkdsa/ulVSlOWhA7tsC1U48eyjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pil0cDP6/mpFtZl8d68CHawHFq8cNmz5DEIbwf0h5EIxn1f+xlAbA8Ssj5ybxaafO8
         /sZgz1V9JQ+PetIKWZze6hd5VXlH3z8z+z/v5HXQkFkPqOTMDSQ9juJVGOlZ9m/10zMi
         NRjKpw46X31vwzn/GYH9AgJaZ01YmyaH7PrS8=
Received: by 10.220.77.75 with SMTP id f11mr7307198vck.85.1246396963819; Tue, 
	30 Jun 2009 14:22:43 -0700 (PDT)
In-Reply-To: <20090630193135.GA4460@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122545>

On Tue, Jun 30, 2009 at 12:31 PM, Jeff King<peff@peff.net> wrote:
>
> I think you can do this a little more simply and efficiently as:
>
> =A0git log -z -p --format=3D'GREP: %s' |
> =A0 =A0perl -0ne 'print if /^[-+].*foo/m && !/^GREP:.*dont_want/' |
> =A0 =A0tr '\0' '\n'
>
> (though note that --format is new as of 1.6.3, I think; before that y=
ou
> have to use "--pretty=3Dformat:"). Many fewer process invocations, an=
d
> less typing, though still easy to mess up.

I agree that --format leads to a much prettier solution.
Unfortunately --format seems to turn off -z (at least in msysgit):

$ git --version
git version 1.6.3.2.1299.gee46c
$ git log -p > L1
$ git log -p -z > L2
$ diff L1 L2 | wc
   2415    4347   62889
$ git log -p --format=3D%s > L1
$ git log -p -z --format=3D%s > L2
$ diff L1 L2 | wc
      0       0       0
