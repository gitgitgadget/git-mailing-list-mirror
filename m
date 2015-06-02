From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFCv2 12/16] transport: get_refs_via_connect exchanges
 capabilities before refs.
Date: Tue, 2 Jun 2015 15:19:44 -0700
Message-ID: <CAGZ79kaTusesFuMZ92797CGw_pbTp8GQ4-nhJ_ciVTXobbLepQ@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-13-git-send-email-sbeller@google.com>
	<xmqqr3ptzsfj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 00:20:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzuXP-0000aS-J9
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 00:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbbFBWTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 18:19:49 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33348 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbbFBWTp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 18:19:45 -0400
Received: by qkhg32 with SMTP id g32so109671607qkh.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 15:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AYQGbzut0+vNlWEWP/4zBTQkFoCFQgvjGh8tMOwj7yM=;
        b=pTpt942pc1HtVjvcJzx2Zoz7ltPUcCaR9WEq4N8lEJrr//cfKrbyrzup70AaKdfXSh
         AYfuwbUdx1DKkb8RGnDaSfy1TDfAgiS+x0lcW7b6A/ZddK7wTqt36SHEtEOnjHA0Ekx1
         vafmQ4DPMdj1qWnajccDh+YO03R8GkyslgPxFXAp71CO34vpn8OXBo/PKn3e06Wzd5a8
         U3o555wvRS/6+jWkADVumT/5pPQbb6UqpquwPjIKxT9epqrX0HV1lK2rgH1j7RnnLQLC
         tSszFXxqpWFsVL9Z25QPG39YjlDtu0Y6PVYXOkCybNnRdAtJ4qgO9x/fXs65WZR665nJ
         gfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AYQGbzut0+vNlWEWP/4zBTQkFoCFQgvjGh8tMOwj7yM=;
        b=i4RVldnNn9vkQ3/h7a6b08Pm/2cfMTAoy1nC4koyEc/fQrY7gPJNBpslX8kU60Q4js
         NfRKGk+P2eWoMKg4tosU3g5VBfaXYSc5j42qdV864ehrhjFosDIHzXOmSjnY4N6EuqWK
         rimacbkOtZhFHkPes+EKodfOYf9aFw/NbIN+E6svlJJRyJPQn6b+giDIQ50/KeROpx5D
         qEk4C8HI7bVeNbOyck92H8oI3NeqWsiiCVh85ztITB0HtoMzNlCY65c43MGkFkJhfeM0
         keHEJtYJSDZlAp9TP6k11IJvbht0ATDJbYV33Cyz592Iz8vsHCI4nrMK3qrbJL8/GOFC
         /UbQ==
X-Gm-Message-State: ALoCoQnia8IJOwEINYLX4LEX6jIivJoarvLnSmFl7zejgs+Krtyq0+TYK9lWWsXb43SKGkY1zhl2
X-Received: by 10.140.96.202 with SMTP id k68mr31424637qge.102.1433283584596;
 Tue, 02 Jun 2015 15:19:44 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 15:19:44 -0700 (PDT)
In-Reply-To: <xmqqr3ptzsfj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270617>

On Tue, Jun 2, 2015 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Notes:
>>     A minor issue I am unsure about here is the
>>     line
>>       && transport->smart_options->transport_version)
>>     which could be prevented if we always set the transport_version
>>     in make_remote to be the default remote version.
>>
>>     The advantage of having it always set in make_remote would
>>     be a cleaner mind model (the version set is always accurate)
>>     as opposed to now (version may be 0, then the default
>>     applies as we don't care enough to set a version)
>>
>>     However I think the code may be more ugly if we were to
>>     always set the version in make_remote as then we would need
>>     to move the DEFAULT_TRANSPORT_VERSION define into remote.h
>>     or somewhere else (transport.h is not included in remote.c,
>>     I guess that's on purpose?)
>
> Interesting.  After reading 9/16, I was somehow expecting to see
> that a new method get_capability() would be added to the transport
> layer, and a function get_capability_via_connect() that calls
> get_remote_capabilities() would be its implementation for the
> "connect" transport.

This suggests that we collect the capabilities at first and then handover
a (possibly huge) list to the upper calling layer with all our capabilities.

Peff pointed out last Friday (I re-read the email on Monday unfortunately),
that we don't want to have buffers of capabilities at all for future extension.

So the design we need to actually have here is to have a callback given to the
transport layer, which calls this callback for each capability received.
Then the upper layer must decide for each capability if it knows it and wants
to store it or drop it or just set a flag for it.

>
> The capability thing however is limited to the Git-aware aka smart
> transports and it is unlikely that other transports would benefit
> from such an organization, so I think the way this step integrates
> the new get_remote_capabilities() to the system would be not just
> sufficient but is more appropriate.
>
> If you do not like the switching based on version in this function,
> however, it is probably an option to add the new method and define
> connect_v1 and connect_v2 as two separate transports.  The latter
> would have get_capability() method, while the former (and all the
> other transports) does not define it.  And the overall transport
> layer would call get_capability() method when defined, and then
> get_refs() method next, or something like that.

The way you quoted my previous email, it seems to me as if you specially
want to address my concerns from the notes.
However my actual concern was only focused on the one line if we do

+       if (transport->smart_options
+           && transport->smart_options->transport_version) // <-- this line
+               version = transport->smart_options->transport_version;

or rather want to have it a bit cleaner with

+       if (transport->smart_options)
+               version = transport->smart_options->transport_version;

This second approach assumes transport->smart_options->transport_version;
to be not NULL, i.e. when setting up the smart options we must make the
decision which protocol version to use. At this point in time this would be
just initializing the transport_version correctly in remote.h. But that's more
lines than just this one.


>
>>  transport.c | 28 ++++++++++++++++++++++++----
>>  transport.h |  6 ++++++
>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/transport.c b/transport.c
>> index b49fc60..ba40677 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -523,14 +523,33 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
>>
>>  static struct ref *get_refs_via_connect(struct transport *transport, int for_push)
>>  {
>> +     struct transport_options options;
>>       struct git_transport_data *data = transport->data;
>>       struct ref *refs;
>> +     int version = DEFAULT_TRANSPORT_VERSION;
>>
>> +     if (transport->smart_options
>> +         && transport->smart_options->transport_version)
>> +             version = transport->smart_options->transport_version;
>>       connect_setup(transport, for_push, 0);
>> -     get_remote_heads(data->fd[0], NULL, 0, &refs,
>> -                      for_push ? REF_NORMAL : 0,
>> -                      &data->extra_have,
>> -                      &data->shallow);
>> +     switch (version) {
>> +     case 2: /* first talk about capabilities, then get the heads */
>> +             get_remote_capabilities(data->fd[0], NULL, 0);
>> +             preselect_capabilities(&options);
>> +             if (transport->select_capabilities)
>> +                     transport->select_capabilities(&options);
>> +             request_capabilities(data->fd[1], &options);
>> +             /* fall through */
>> +     case 1:
>> +             get_remote_heads(data->fd[0], NULL, 0, &refs,
>> +                              for_push ? REF_NORMAL : 0,
>> +                              &data->extra_have,
>> +                              &data->shallow);
>> +             break;
>> +     default:
>> +             die("BUG: Transport version %d not supported", version);
>> +             break;
>> +     }
>>       data->got_remote_heads = 1;
>>
>>       return refs;
>> @@ -987,6 +1006,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>>               struct git_transport_data *data = xcalloc(1, sizeof(*data));
>>               ret->data = data;
>>               ret->set_option = NULL;
>> +             ret->select_capabilities = NULL;
>>               ret->get_refs_list = get_refs_via_connect;
>>               ret->fetch = fetch_refs_via_pack;
>>               ret->push_refs = git_transport_push;
>> diff --git a/transport.h b/transport.h
>> index 6095d7a..3e63efc 100644
>> --- a/transport.h
>> +++ b/transport.h
>> @@ -74,6 +74,12 @@ struct transport {
>>       int (*fetch)(struct transport *transport, int refs_nr, struct ref **refs);
>>
>>       /**
>> +      * A callback to select protocol options. Must be set if
>> +      * the caller wants to change transport options.
>> +      */
>> +     void (*select_capabilities)(struct transport_options *);
>> +
>> +     /**
>>        * Push the objects and refs. Send the necessary objects, and
>>        * then, for any refs where peer_ref is set and
>>        * peer_ref->new_sha1 is different from old_sha1, tell the
