From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3] Clarify pre-push hook documentation
Date: Wed, 26 Mar 2014 23:21:21 -0000
Organization: OPDS
Message-ID: <3CA35D0B7B7C411292360D1516EF409B@PhilipOakley>
References: <1395704609-81957-1-git-send-email-dcow90@gmail.com><1395705088-82216-1-git-send-email-dcow90@gmail.com> <xmqqmwgemceq.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>, <sunshine@sunshineco.com>
To: "Junio C Hamano" <gitster@pobox.com>,
	"David Cowden" <dcow90@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 00:21:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSx8N-0006nL-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 00:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbaCZXVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 19:21:19 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:58486 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752126AbaCZXVS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2014 19:21:18 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvEYADtgM1NZ8YM+/2dsb2JhbABZgwY7iSC6LAEBAgEBgRgXdGkBAYEfAQEUAQQBAQEBAgEIAQEuHgEBIQsCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYU4BwGCBw0DCQwJtDeVMQ2HX4xVghyDK4EUBIkahiSHIoMgizaFSoMuPQ
X-IPAS-Result: AvEYADtgM1NZ8YM+/2dsb2JhbABZgwY7iSC6LAEBAgEBgRgXdGkBAYEfAQEUAQQBAQEBAgEIAQEuHgEBIQsCAwUCAQMVDCUUAQQIEgYHFwYBEggCAQIDAYU4BwGCBw0DCQwJtDeVMQ2HX4xVghyDK4EUBIkahiSHIoMgizaFSoMuPQ
X-IronPort-AV: E=Sophos;i="4.97,738,1389744000"; 
   d="scan'208";a="449634798"
Received: from host-89-241-131-62.as13285.net (HELO PhilipOakley) ([89.241.131.62])
  by out1.ip05ir2.opaltelecom.net with SMTP; 26 Mar 2014 23:21:16 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245258>

From: "Junio C Hamano" <gitster@pobox.com>
> David Cowden <dcow90@gmail.com> writes:
>
>> The documentation as-is does not mention that the pre-push hook is
>> executed even when there is nothing to push.  This can lead a new
>> reader to believe there will always be lines fed to the script's
>> standard input and cause minor confusion as to what is happening
>> when there are no lines provided to the pre-push script.
>>
>> Signed-off-by: David Cowden <dcow90@gmail.com>
>> ---
>>
>> Notes:
>>     I'm not sure if I've covered every case here.  If there are more
>> cases to
>>     consider, please let me know and I can update to include them.
>
> I do not think of any offhand, but a more important point that I was
> trying to get at was that we should not give an incorrect impression
> to the readers that the scenario that is described is the only case
> they need to be worried about by pretending to be exhaustive.
>
> The "may" in your wording "This may happen when" may be good enough
> to hint that these may not be the only cases.
>
>>     c.f.
>> http://stackoverflow.com/questions/22585091/git-hooks-pre-push-script-does-not-receive-input-via-stdin
>>
>>  Documentation/githooks.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
>> index d954bf6..1fd6da9 100644
>> --- a/Documentation/githooks.txt
>> +++ b/Documentation/githooks.txt
>> @@ -203,6 +203,15 @@ SHA-1>` will be 40 `0`.  If the local commit was
>> specified by something other
>>  than a name which could be expanded (such as `HEAD~`, or a SHA-1) it
>> will be
>>  supplied as it was originally given.
>>
>> +The hook is executed regardless of whether changes will actually be
>> pushed or
>> +not.  This may happen when 'git push' is called and:
>> +
>> + - the remote ref is already up to date, or
>> + - pushing to the remote ref cannot be handled by a simple
>> fast-forward
>> +
>> +In other words, the script is called for every push.  In the event
>> that nothing
>> +is to be pushed, no data will be provided on the script's standard
>> input.

Doesn't an 'in other words' indicate it could be further tightened?
Maybe
    "If there is nothing to push, the hook will still run, but the input
    line will be empty.

    Likewise the hook will still run for other cases such as:
    - the remote ref is already up to date,
    - pushing to the remote ref cannot be handled by a simple
      fast-forward,
    - etc."

>
> When two things are to be pushed, the script will see the two
> things.  When one thing is to be pushed, the script will see the one
> thing.  When no thing is to be pushed, the script will see no thing
> on its standard input.
>
> But isn't that obvious?  I still wonder if we really need to single
> out that "nothing" case.  The more important thing is that it is
> invoked even in the "0-thing pushed" case, and "the list of things
> pushed that is given to the hook happens to be empty" is an obvious
> natural fallout.

Personally I think it should be mentioned in that paragraph, which is
covering all the various special cases. The 'nothing' case often causes
confusion when it's not specified in documentation.
>
>>  If this hook exits with a non-zero status, 'git push' will abort
>> without
>>  pushing anything.  Information about why the push is rejected may be
>> sent
>>  to the user by writing to standard error.
> --

It may be that the documentation should include the caveat

    "Hooks, when enabled, are executed unconditionally by their calling
    functions.
     Script writers should ensure they handle all conditions."

somewhere near the top of the page to cover all hooks, which IIRC
started David's journey. That would allow my second paragraph
"Likewise.." to be dropped.

Philip
--
[apologies for any whitespace damage]
