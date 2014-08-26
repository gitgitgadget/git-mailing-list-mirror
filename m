From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Tue, 26 Aug 2014 10:33:58 -0700
Message-ID: <CAJo=hJs3m-0u7NkPHJqvk4qZBGtPguck-xn=in3m-+30UxDQoA@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <1408485987-3590-19-git-send-email-gitster@pobox.com> <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
 <xmqqvbplpg2s.fsf@gitster.dls.corp.google.com> <xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
 <CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com> <xmqqd2bomowm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:34:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKdU-000830-7j
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbaHZReU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:34:20 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:45773 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbaHZReT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:34:19 -0400
Received: by mail-ie0-f176.google.com with SMTP id tr6so11999733ieb.21
        for <git@vger.kernel.org>; Tue, 26 Aug 2014 10:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=F4ldfnrYb7hEZqrNJX953nKb6q6+dE/79ZOSiM2cnE8=;
        b=IqXJVzqg3nsMIRTuA7LNNTZVcj9ZtMuiG7ZWEveGzsTfDd/6lrYP+q+X0jBBIStzQF
         vbyj9gfGZiaaoth9pjNQNmZmqSFGtTjPgk+XzXbHawudEtJYDGk1GC0M0rzH3/tVOXW/
         VaAPOLG9HHciImqqpM8JEv7/FT+y4xGQh/tfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=F4ldfnrYb7hEZqrNJX953nKb6q6+dE/79ZOSiM2cnE8=;
        b=IiauAjQxh8sE6E67gdE+6tvInjMiynQu8qqMPItA+EDwhCJXJwA2hUO6d9Bq4eqfMb
         RZRgsWzuh7U7qB1mbyy0avzvsFr/5PgN3NTyHdJTlwtMaQMpRD7I0het+Huee/SXnunx
         SzIHpj8nIOemE/y1bJGrFS1WvJSACN+UVELARmG2eXhl2ixOw7IEqU9YTqpOsfwCTsX4
         p8gyoXFg1+lyj677rPBRG3CRAkaO1lDXdyJaA4FW0JpJhyJ7WXN0nqXJYXiPkxT82/fM
         3xeYxFzIxuucEqzEw+GOharN2VLTy/57NhguMQYm0/mEf34XOfVEPhSjVM/p8qTThdUg
         MMoQ==
X-Gm-Message-State: ALoCoQkNPS3mMb/WCHMK51PJ7QFmKOJCFtl/oVOfFK8vsqmf219zRr2K4rJL4iabrH1qmRkQPG9d
X-Received: by 10.50.108.103 with SMTP id hj7mr23794721igb.5.1409074458912;
 Tue, 26 Aug 2014 10:34:18 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Tue, 26 Aug 2014 10:33:58 -0700 (PDT)
In-Reply-To: <xmqqd2bomowm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255926>

On Mon, Aug 25, 2014 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> A stateless nonce could look like:
>>
>>   nonce = HMAC_SHA1( SHA1(site+path) + '.' + now, site_key )
>>
>> where site_key is a private key known to the server. It doesn't have
>> to be per-repo.
>>
>> receive-pack would then be willing to accept any nonce whose timestamp
>> is within a window, e.g. 10 minutes of the current time, and whose
>> signature verifies in the HMAC. The 10 minute window is important to
>> allow clients time to generate the object list, perform delta
>> compression, and begin transmitting to the server.
>
> Hmph, don't you send the "finally tell the other end" the sequence
> of "update this ref from old to new" and the packdata separately?

No. The command list (triples of old, new, ref) is sent in the same
HTTP request as the pack data, ahead of the pack data. So its one
request.

Push on smart HTTP is 3 HTTP requests:

  1)  get advertisement
  2)  POST empty flush packet to tickle auth (literally just "0000").
  3)  POST command list + pack

The nonce can be sent server->client in 1, and client->server in 3.

>  I
> think we have a FLUSH in between, and the push certificate is given
> before the FLUSH, which you do not have to wait for 10 minutes.

Nope I think you need to wait for the pack to generate enough to start
sending the pack data stream. Nothing forces the smart HTTP client to
push its pending buffer out. We wait for the pack data to either
finish, or overflow the in-memory buffer, and then start transmitting.
If your client needs a lot of time for counting and delta compression,
we aren't likely to overflow and transmit for a while.

If you send a _lot_ of refs you can overflow, which will cause us to
transmit early. But we are talking about megabytes worth of (old, new,
ref) triplets to reach that overflow point.
