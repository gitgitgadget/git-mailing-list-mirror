From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Wed, 10 Feb 2016 13:01:15 -0800
Message-ID: <20160210210115.GA10155@google.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 22:01:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTbtS-0007Sh-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 22:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbcBJVBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 16:01:42 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36469 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbcBJVBl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 16:01:41 -0500
Received: by mail-pf0-f170.google.com with SMTP id e127so17802543pfe.3
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 13:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iZuR0GLVX6japRI99/MZeoLuWYszqMERMw2ZOVyUH3A=;
        b=z4vGGHk9Bq78TyKADE8M0E07jvANHjbgmjFR5cTN5hQAOaqB4n8Y/Nq+HH+vFKnpmo
         bVX5U5uHN0n3+q2H38ylYi3N7Ig2673E9Nzavv8fl4ajdH1T55AjkIh4kJ21+jajPX48
         WiKS4hX9xwuPipzHxDQRRFiNwr4Qy3wMmx615ZigjdRomp0NrpQ790LvOCEJxjuHifOC
         Ry+LgThbzkLZyWtooF7UUn1ognQjjf/OsFhVq7EhgBNchZontV3G8s3jatzv3D2WFts/
         UyGtri+7b6O4ow1uvHBzz3NS5nMH+oFo4kaDxslv7Qd7a58iZYEJtBqB09haba2oCyPt
         4KaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=iZuR0GLVX6japRI99/MZeoLuWYszqMERMw2ZOVyUH3A=;
        b=K5AMcsZGZnzabeF8EpVPqwvjbNAeyWibhUoU2nKysJl4NWK1A8zTN7msj7tFyVle6n
         KO2BuD0vb36VVNDviEf+6tqd3cAczJzxMIgI5W5BkVSych814fiHOms+EIEBAEdpanRh
         MFvRW9neOdrFvAi1qBb2xn1uwsKC+qz9JYKUBT3yDAfS4m1LFqH9s/xS1eVRNGg5b96R
         BeFaZhx756Mc50bxQaG8HB4sTVS8RnBdaatCIIiigynoJD2urevZi/0AN7wVNPjF1Pxz
         u61N1/inYqGRe44Y0/ptAYMFX0xNi8Vvzm5F44w4WOKFSoZaD6rRRmXOtfMHvsFyUTJp
         odog==
X-Gm-Message-State: AG10YOS15L+yNLtCV1LfAJHAihKMltz/9J1shpJUUGjL4sAP15JWerWxzisK2mHW9UbVRw==
X-Received: by 10.98.93.2 with SMTP id r2mr45472353pfb.64.1455138100630;
        Wed, 10 Feb 2016 13:01:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:986b:44f8:244c:add9])
        by smtp.gmail.com with ESMTPSA id l14sm7209461pfb.73.2016.02.10.13.01.39
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 10 Feb 2016 13:01:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285926>

Stefan Beller wrote:
> On Wed, Feb 10, 2016 at 12:11 PM, Shawn Pearce <spearce@spearce.org> wrote:

>> Several of us at $DAY_JOB talked about this more today and thought a
>> variation makes more sense:
>>
>> 1. Clients attempting clone ask for /info/refs?service=git-upload-pack
>> like they do today.
>>
>> 2. Servers that support resumable clone include a "resumable"
>> capability in the advertisement.
>
> like "resumable-token=hash" similar to a push cert advertisement?

It could just be the string 'resumable'.

But I wonder if it would be possible to save a round-trip by getting the
302 response in the initial request.  If the client requests

	/info/refs?service=git-upload-pack&want_resumable=true

then allow the server to make a 302 in response to its current mostly
whole pack.  Current clients would never send such a request because the
current protocol requires that for smart clients

	The request MUST contain exactly one query parameter,
	`service=$servicename`, where `$servicename` MUST be the service
	name the client wishes to contact to complete the operation.
	The request MUST NOT contain additional query parameters.

Current http-backend ignores extra query parameters.  I haven't
checked other smart http server implementations, though.

>> 3. Updated clients on clone request GET /info/refs?service=git-resumable-clone.
>
> Or just in the non-http case, they would terminate after the ls-remote
> (including capability advertisement) was done and connect again to
> a different service such as git-upload-stale-pack with the resumable
> token to identify the pack.

HTTP supports range requests and existing CDNs speak HTTP, so I
suspect it would work better if the git-resumable-clone service
printed an HTTP URL from which to grab the packfile.

I think the details are something that could be figured out after
trying out the idea with http first, though.

[...]
>> 5. Clients fetch the file using standard HTTP GET, possibly with
>> byte-ranges to resume.
>
> In the non-http case the git-upload-stale-pack would be rsync with the
> resume token to determine the file name of the pack,
> such that we have resumeability.

How do I tunnel rsync over git protocol?

So I think in the non-http case the git-resumable-clone service would
have to print a URL to be served using a possibly different protocol
(e.g., a signed https URL for getting the file from a service like S3,
or an rsync URL for getting the file using the same ssh creds that
were used for the initial request).

[...]
>> 6. Once stored and indexed with .idx, clients run `git fsck
>> --lost-found` to discover the roots of the pack it downloaded. These
>> are saved as temporary references.
>
> jrn:
> > I suspect we can do even faster by making index-pack do the work
>
>     index-pack --check-self-contained-and-connected

--strict + --check-self-contained-and-connected check that the pack
is self-contained.  In the process they mark each object that is
reachable from another object in the pack with FLAG_LINK.

The objects not marked with FLAG_LINK are the roots.

[...]
>> To make step 4 really resume well, clients may need to save the first
>> Location header it gets back from
>> /info/refs?service=git-resumable-clone and use that on resume. Servers
>> are likely to embed the pack SHA-1 in the Location header, and the
>> client wants to use this on subsequent GET attempts to abort early if
>> the server has deleted the pack the client is trying to obtain.

Yes.

I really like this design.  I'm tempted to implement it (since it
lacks a bunch of the downsides of clone.bundle).

Thanks,
Jonathan
