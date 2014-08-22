From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 18/18] signed push: final protocol update
Date: Fri, 22 Aug 2014 16:54:08 -0700
Message-ID: <CAJo=hJu_T7irRk=fBsJ+GQxbVQ9GgO2ytihxKm+bXSLsL+wQbg@mail.gmail.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
 <1408485987-3590-19-git-send-email-gitster@pobox.com> <CAJo=hJuToRQDTkccV9BfVbs1YnjCrr2iPrG-HmTbJ=ds4r6MzA@mail.gmail.com>
 <xmqqvbplpg2s.fsf@gitster.dls.corp.google.com> <xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKyfk-0005In-Tz
	for gcvg-git-2@plane.gmane.org; Sat, 23 Aug 2014 01:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbaHVXyn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 19:54:43 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:61895 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbaHVXye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 19:54:34 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so459979igc.12
        for <git@vger.kernel.org>; Fri, 22 Aug 2014 16:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4PvPuh5vW+jDdYpefCQbsnNhIx6nPMuXVTzvwdL97vo=;
        b=LS2Bx6pZFA0znNlsc4HiSdkYRT3kbZxdW7tsNwxZ9655fVsQv06KJSOS47UM3ovhQQ
         ujSScp5t9NqrL94/61zCMxbxLkWXJUn4jInwG7oNipEXIsO8ubhqfEYg5gVsA1xI6Pv7
         l8w3hLbfWo5IikcZA8nmn9fve1ZiI1G6pCL9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=4PvPuh5vW+jDdYpefCQbsnNhIx6nPMuXVTzvwdL97vo=;
        b=Nvu8UiBX/dEa1xa2WQ9H+pSEaVEufqlDKlgSTnEv7u3tTMxmPqOWUI0BGTrDUq7OJD
         opxSugSlSwlP+JISZpmIPsj5oiw6O61EE+OceFxtSHyzqOhbLzjB6DRAavb+ymywlIMj
         fOuYVHgOIkA7yjWKBNmYyyhRkV2gZ6pX7AIIFgy4InIPrPOzfhuTsLbVVex9TMxNzVvF
         5/N1h4GetMUL6/v/RNGGjOAvrxS3FnmttOsy3rEdTvoW9U27cOkp/27lBTCcdW/YhUp1
         ZvCtU4WXBbuNbn+q4QCvxNRh7UaoXAQZGKvbDEmugfvRV/Xqcfs/mb7UPXBVnIuUQT70
         KXnw==
X-Gm-Message-State: ALoCoQlG+iIAJSzRhBtdjrCnnWYSehNk3xdPs27/Oa1kzeItmRnmFO3RqzJdZOhQpM0cqKavdPRj
X-Received: by 10.43.94.73 with SMTP id bx9mr11866739icc.19.1408751668477;
 Fri, 22 Aug 2014 16:54:28 -0700 (PDT)
Received: by 10.64.245.164 with HTTP; Fri, 22 Aug 2014 16:54:08 -0700 (PDT)
In-Reply-To: <xmqqa96wpfqb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255726>

On Fri, Aug 22, 2014 at 10:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> There are a few gotchas I can certainly use help on, especially from
>> a smart-http expert ;-).
>>
>>  * "pushed-to <URL>" will identify the site and the repository, so
>>    you cannot MITM my push to an experimental server and replay it
>>    against the authoritative server.
>>
>>    However, the receiving end may not even know what name its users
>>    call the repository being pushed into.  Obviously gethostname()
>>    may not be what the pusher called us, and getcwd() may not match
>>    the repository name without leading "/var/repos/shard3/" path
>>    components stripped, for example.
>>
>>    I am not sure if we even have the necessary information at
>>    send-pack.c::send_pack() level, where it already has an
>>    established connection to the server (hence it does not need to
>>    know to whom it is talking to).
>>
>>
>>  * The receiving end will issue "push-cert=<nonce>" in its initial
>>    capability advertisement, and this <nonce> will be given on the
>>    PUSH_CERT_NONCE environment to the pre/post-receive hooks, to
>>    allow the "nonce <nonce>" header in the signed certificate to be
>>    checked against it.  You cannot capture my an earlier push to the
>>    authoritative server and replay it later.
>>
>>    That would all work well within a single receive-pack process,
>>    but with "stateless" RPC, it is unclear to me how we should
>>    arrange the <nonce> the initial instance of receive-pack placed
>>    on its capability advertisement to be securely passed to the
>>    instance of receive-pack that actually receives the push
>>    certificate.
>
> A good <nonce> may be something like taking the SHA-1 hash of the
> concatenation of the sitename, repo-path and the timestamp when the
> receive-pack generated the <nonce>.  Replaying a push certificate
> for a push to a repository at a site that gives such a <nonce> can
> succeed at the same chance of finding a SHA-1 collision [*1*].  As
> long as you exercise good hygiene and only push to repositories that
> give such <nonce>, we can do without checking "pushed-to" that says
> where the push went.

Yes, this is an interesting solution.

As you know, the stateless HTTP thing doesn't allow the nonce on the
server to be carried from the initial ref advertisement into the final
receive-pack. We would either need to write the nonce to disk and load
it back up later (ick), or use some sort of stateless nonce.

A stateless nonce could look like:

  nonce = HMAC_SHA1( SHA1(site+path) + '.' + now, site_key )

where site_key is a private key known to the server. It doesn't have
to be per-repo.

receive-pack would then be willing to accept any nonce whose timestamp
is within a window, e.g. 10 minutes of the current time, and whose
signature verifies in the HMAC. The 10 minute window is important to
allow clients time to generate the object list, perform delta
compression, and begin transmitting to the server.

> So "nonce <nonce>" is the only thing that is necessary to make them
> impossible to replay.  For auditing purposes, "pushed-to <URL>" that
> records the repository the pusher intended to push to may help but
> probably not necessary [*2*].

So pushed-to is still useful as a documentation/historical artifact,
but isn't important for verifying the certificate. That fixes a lot of
problems with repositories having different paths under e.g. git://
vs. ssh:// vs. https:// on the same host.
