From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 4/4] git gui: allow for a long recentrepo list
Date: Thu, 17 Dec 2015 22:11:29 -0000
Organization: OPDS
Message-ID: <2F62ABA2EE734F5F926C9E102969895F@PhilipOakley>
References: <1450310287-4936-1-git-send-email-philipoakley@iee.org><1450310287-4936-5-git-send-email-philipoakley@iee.org> <xmqqsi30c1lk.fsf@gitster.mtv.corp.google.com> <1CAD7B4439DF4AE19EE8CD56CB47F399@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Pat Thoyts" <patthoyts@users.sourceforge.net>,
	"Alexey Astakhov" <asstv7@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 23:11:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9glr-00075i-HO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 23:11:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933513AbbLQWLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 17:11:31 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:55512 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932226AbbLQWLa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 17:11:30 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CmBwDUMXNWPK4lFlxeHQ8BAQEBgwpSbYdNs3OEAgcXCoViBAEDAQGBPk0BAQEBAQEHAQEBAUABP4QvBgEBBAgBAS4WCAEBIQsCAwUCAQMVDCUUAQQYAgYHAxQGCAsIAgECAwEMBIgSCrJAi1qGVoR+hCgMAYNxgRoFjXCJDQGBMoQGiWtJlwSDdIRoPjQBgx4BH4ErAQEB
X-IPAS-Result: A2CmBwDUMXNWPK4lFlxeHQ8BAQEBgwpSbYdNs3OEAgcXCoViBAEDAQGBPk0BAQEBAQEHAQEBAUABP4QvBgEBBAgBAS4WCAEBIQsCAwUCAQMVDCUUAQQYAgYHAxQGCAsIAgECAwEMBIgSCrJAi1qGVoR+hCgMAYNxgRoFjXCJDQGBMoQGiWtJlwSDdIRoPjQBgx4BH4ErAQEB
X-IronPort-AV: E=Sophos;i="5.20,443,1444690800"; 
   d="scan'208";a="572637023"
Received: from host-92-22-37-174.as13285.net (HELO PhilipOakley) ([92.22.37.174])
  by out1.ip03ir2.opaltelecom.net with SMTP; 17 Dec 2015 22:35:44 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282681>

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Junio C Hamano" <gitster@pobox.com>, December 17, 2015 7:32 PM
>> Philip Oakley <philipoakley@iee.org> writes:
>>
>>> The gui.recentrepo list may be longer than the maxrecent setting.
>>> Allow extra space to show any extra entries.
>>>
>>> In an ideal world, the git gui would limit the number of entries
>>> to the maxrecent setting, however the recentrepo config list may
>>> have been extended outside of the gui, or the maxrecent setting changed
>>> to a reduced value. Further, when testing the gui's recentrepo
>>> logic it is useful to show these extra, but valid, entries.
>>
>> I do not have a strong objection either way, but the magic number 5
>> smells like an indication that this is solving a wrong problem or
>> solving a problem in a wrong approach.  What happens to the entries
>> beyond $maxrecent-th in the recent list with the current code?  The
>> list effectively truncated and not shown?  Wouldn't the same thing
>> happen to the entries beyond ($maxrecent+5)-th in the recent list
>> with your patch?
>
> True, it was a magic number selected as being a moderate overspill 
> allowance.
> I tried 3 and 5 as possible values, and 5 didn't look ungainly, even on my 
> small netbook, and covered all my test hacking cases.
>
> The issue was that the prior code assumed that the fault could never 
> happen and limited the display, which is sorted, to the max value, so in a 
> fault condition the most recent repo could fall off the bottom.
>
> As a bit of 'monkey patching' I wasn't sure how the dialog creation could 
> know in advance how long the list would be, so I simply added on a small 
> margin.
>
>>
>> Truncating the list at $maxrecent-th to match the display
>> (i.e. declare that "$maxrecent" is really the max number of entries
>> we would keep track of), or allowing the UI to scroll so that
>> entries beyond $maxrecent-th one can be shown, perhaps?
>
> This would certainly be a reasonable approach, but I don't know enough of 
> the tcl to know how to make it happen. If anyone has suggestions...

I think I see the way to do it. V3 Patch 4/4 to follow.
>
>>
>>>
>>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>>> ---
>>> word usage corrected.
>>> Eric's comments $gmane/282432
>>> ---
>>>  git-gui/lib/choose_repository.tcl | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/git-gui/lib/choose_repository.tcl 
>>> b/git-gui/lib/choose_repository.tcl
>>> index ad7a888..a08ed4f 100644
>>> --- a/git-gui/lib/choose_repository.tcl
>>> +++ b/git-gui/lib/choose_repository.tcl
>>> @@ -153,7 +153,7 @@ constructor pick {} {
>>>  -background [get_bg_color $w_body.recentlabel] \
>>>  -wrap none \
>>>  -width 50 \
>>> - -height $maxrecent
>>> + -height [expr {$maxrecent + 5}]
>>>  $w_recentlist tag conf link \
>>>  -foreground blue \
>>>  -underline 1
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
