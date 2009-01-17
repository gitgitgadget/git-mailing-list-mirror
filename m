From: "Ray Chuan" <rctay89@gmail.com>
Subject: Re: [PATCH 2/3] http-push: when sending objects, don't PUT before MOVE
Date: Sat, 17 Jan 2009 12:08:33 +0000
Message-ID: <be6fef0d0901170408g48139ceai2831978b764b805d@mail.gmail.com>
References: <be6fef0d0901161859g4e5d749et78b6b0231eb915ee@mail.gmail.com>
	 <alpine.DEB.1.00.0901170706450.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 17 13:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LO9zz-0001r4-Ac
	for gcvg-git-2@gmane.org; Sat, 17 Jan 2009 13:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753457AbZAQMIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 07:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbZAQMIf
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 07:08:35 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:11599 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbZAQMIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 07:08:34 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1094378wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 04:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EzQzSmDz13+XQ0t91fmyeEYFmaproj6AlEW9Sp/a9ck=;
        b=EKn0JI/IDGi5qoQPerI4RZrrZ9b4Z2RAHUqkw6H4DBvJhl87tUPNOxRXiEt0wh6eEj
         3yHXg9bDlGLoAQlwGh0DEP8B5zY919xC4+DZQQYrUu0KXM+eoOlIQHtyfLOdgC+PinPn
         QM6kvmCtI826vJFs7dkK72mHydhBm8O8ggGG8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=sZ1kxkX4w6Lny9vEMYXEMpI3YaAkAYb2dbqgFUE9VTnxfcgUtK7Tv0e4AbylcPj0m6
         2gwWrB4YhLv4MH6M7SNTesVkkT8Z+LvIIVkYtoGuIU43BQf3yJiz26ZETSTe6wy0t0lx
         +p3MOdKP3Qzro+53vQsbuEAcmrnfV4Dh6NNuc=
Received: by 10.114.102.1 with SMTP id z1mr1160623wab.186.1232194113387;
        Sat, 17 Jan 2009 04:08:33 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 04:08:33 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901170706450.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106044>

Hi,

On Sat, Jan 17, 2009 at 2:13 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 17 Jan 2009, Ray Chuan wrote:
>
>> since 753bc911f489748a837ecb5ea4b5216220b24845, the opaquelocktocken
>
> It would be nice to use the form <abbrev-sha1>(<oneline>) instead of a
> non-abbreviated SHA-1 that everybody who is interested has to look up,
> wasting time.

sorry, i was referring to 753bc91 (Remove the requirement
opaquelocktoken uri scheme).

>> URI isn't used, so it doesn't make sense to PUT then MOVE.
>>
>> currently, git PUTs to
>>
>> /repo.git/objects/1a/1a2b..._opaquelocktoken:1234-....
>
> First you say that the opaquelocktoken URI is not used, but here it looks
> like one?
>
>> on some platforms, ':' isn't allowed in filenames so this fails
>> (assuming the server doesn't recognize it as opaquelocktoken scheme).
>> in fact, i don't think this is the correct implementation of the
>> scheme; 'opaquelocktoken: ' should come in front of the path.
>
> It would be nice to make that a fact-backed commit message.  IOW there has
> to be some documentation about the subject which you can quote, and which
> would give you a definitive answer to the question if it should be a
> prefix or not.

According to the opaquelocktoken URI scheme in RFC2518

 OpaqueLockToken-URI = "opaquelocktoken:" UUID [Extension]

if i'm not wrong, then the URI should read

 opaquelocktoken:1234-....:/repo.git/objects/1a/1a2b...

rather than (currently):

 /repo.git/objects/1a/1a2b..._opaquelocktoken:1234-....

this means either the opaquelocktoken URI scheme wasn't meant to be
implemented, or it is an incorrect implementation.

my belief is of the former, since the URI scheme is meant to represent
the lock token currently held when communicating to the server; in
addition, the lock held doesn't apply to the PUT path; it is
'refs/heads/abranch' rather than 'objects/' that is locked, so it
doesn't make sense to pass the lock token to the server while
accessing 'objects/'.
- Show quoted text -

>> diff --git a/src/git-1.6.1/http-push.c b/src/git-1.6.1/http-push.c
>> index a646a49..838ff6f 100644
>> --- a/src/git-1.6.1/http-push.c
>> +++ b/src/git-1.6.1/http-push.c
>> @@ -31,7 +31,6 @@ enum XML_Status {
>>  /* DAV methods */
>>  #define DAV_LOCK "LOCK"
>>  #define DAV_MKCOL "MKCOL"
>> -#define DAV_MOVE "MOVE"
>>  #define DAV_PROPFIND "PROPFIND"
>>  #define DAV_PUT "PUT"
>>  #define DAV_UNLOCK "UNLOCK"
>> @@ -104,7 +103,6 @@ enum transfer_state {
>>       NEED_PUSH,
>>       RUN_MKCOL,
>>       RUN_PUT,
>> -     RUN_MOVE,
>>       ABORTED,
>>       COMPLETE,
>>  };
>> @@ -528,11 +526,6 @@ static void start_put(struct transfer_request *request)
>>       posn += 2;
>>       *(posn++) = '/';
>>       strcpy(posn, hex + 2);
>> -     request->dest = xmalloc(strlen(request->url) + 14);
>> -     sprintf(request->dest, "Destination: %s", request->url);
>> -     posn += 38;
>> -     *(posn++) = '_';
>> -     strcpy(posn, request->lock->token);
>>
>>       slot = get_active_slot();
>>       slot->callback_func = process_response;
>
> Color me puzzled again.  Why is this code no longer needed?  Is this the
> lock you were talking about?

the first two hunks remove MOVE-specific flags and status codes, while
the last hunk removes code that generates the "Destination: <url>"
header needed for a MOVE, which isn't needed by any other DAV
requests.

it isn't related to locks, although the "source" url would contain the
word lock in the current implementation.

for example, currently, a PUT path appended with a opaquelocktoken is
followed by a MOVE request:

PUT /git/test_repo.git/objects/50/b820aea6d3503362343cdc0e699b760c700b2b_opaquelocktoken:6960ad7a-84b0-9b4e-85cc-b9f15652c658
MOVE /git/test_repo.git/objects/50/b820aea6d3503362343cdc0e699b760c700b2b

(actually, it is the request header 'Destination: ' that contains the
destination path, not the request url; i replaced it for demonstrative
purposes.)

>> @@ -705,23 +672,13 @@ static void finish_request(struct
>> transfer_request *request)
>>               }
>>       } else if (request->state == RUN_PUT) {
>>               if (request->curl_result == CURLE_OK) {
>> -                     start_move(request);
>> -             } else {
>> -                     fprintf(stderr, "PUT %s failed, aborting (%d/%ld)\n",
>> -                             sha1_to_hex(request->obj->sha1),
>> -                             request->curl_result, request->http_code);
>> -                     request->state = ABORTED;
>> -                     aborted = 1;
>> -             }
>
> ... and here comes my first doubt that it would be a good idea to avoid
> "put && move"; what if "put" fails?  Then you end up with a corrupt
> repository.

if we take the "put && move" procedure as a guard against failure (as
opposed to "put"), then how does one explain the fact that this
procedure isn't applied when updating a branch file (eg.
refs/heads/mybranch)?

in any case, "put && move" isn't an effective guard after failure
during put. the PUT sends an object/revision to the repository,
however, the repository doesn't yet know that such an object/revision
exists, cos the ref file for the branch to be updated in the remote
repository (eg. refs/heads/mybranch) has yet to be updated; it is
updated only if the PUT was successful.

thus the repository won't be corrupt if a PUT request fails.


> Ciao,
> Dscho
>
>


-- 
Cheers,
Ray Chuan
