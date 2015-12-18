From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v3 4/4] git gui: allow for a long recentrepo list
Date: Fri, 18 Dec 2015 00:26:07 -0000
Organization: OPDS
Message-ID: <9731888BD4C348F5BFC82FA96D978034@PhilipOakley>
References: <2F62ABA2EE734F5F926C9E102969895F@PhilipOakley><1450392007-600-1-git-send-email-philipoakley@iee.org> <xmqqbn9obqne.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>,
	"Pat Thoyts" <patthoyts@users.sourceforge.net>,
	"Eric Sunshine" <sunshine@sunshineco.com>,
	"Alexey Astakhov" <asstv7@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 01:26:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9isG-0007Oo-U0
	for gcvg-git-2@plane.gmane.org; Fri, 18 Dec 2015 01:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722AbbLRA0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 19:26:11 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:29727 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754666AbbLRA0J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 19:26:09 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CJDgD3UXNWPK4lFlxeGQEBAg8BAQEBgwqBP4ZgbbN0hAmGAwQEAoE4TQEBAQEBAQcBAQEBQAEkG4QvBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiBYMskKLW4ZWhH6ENYNxgRoFjXCJDQGBMo1xh22TVIIugjo+NIMggUoBAQE
X-IPAS-Result: A2CJDgD3UXNWPK4lFlxeGQEBAg8BAQEBgwqBP4ZgbbN0hAmGAwQEAoE4TQEBAQEBAQcBAQEBQAEkG4QvBQEBAQECAQgBAS4eAQEhBQYCAwUCAQMVDCUUAQQaBgcDFAYTCAIBAgMBiBYMskKLW4ZWhH6ENYNxgRoFjXCJDQGBMo1xh22TVIIugjo+NIMggUoBAQE
X-IronPort-AV: E=Sophos;i="5.20,443,1444690800"; 
   d="scan'208";a="623312117"
Received: from host-92-22-37-174.as13285.net (HELO PhilipOakley) ([92.22.37.174])
  by out1.ip04ir2.opaltelecom.net with SMTP; 18 Dec 2015 00:50:00 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282688>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> The gui.recentrepo list may be longer than the maxrecent setting.
>> Use the actual length determined earlier, now saved as $lenrecent.
>>
>> In an ideal world, the git gui would limit the number of entries
>> to the maxrecent setting, however the recentrepo config list may
>> have been extended outside of the gui, or the maxrecent setting changed
>> to a reduced value. Further, when testing the gui's recentrepo
>> logic it is useful to show these extra, but valid, entries.
>>
>> The list length will be trimmed to $maxrecent after the user selects
>> a repo to open.
>>
>> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>> ---
>> V2:
>> word usage corrected.
>> Eric's comments $gmane/282432
>> V3:
>> Updated list length measure following Junio's comments $gmane/282669
>>
>> Replaces the previous V2 Patch 4/4.
>>
>> ---
>>  git-gui/lib/choose_repository.tcl | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-gui/lib/choose_repository.tcl 
>> b/git-gui/lib/choose_repository.tcl
>> index ad7a888..b4cc7dd 100644
>> --- a/git-gui/lib/choose_repository.tcl
>> +++ b/git-gui/lib/choose_repository.tcl
>> @@ -134,7 +134,8 @@ constructor pick {} {
>>  $opts conf -state disabled
>>
>>  set sorted_recent [_get_recentrepos]
>> - if {[llength $sorted_recent] > 0} {
>> + set lenrecent [llength $sorted_recent]
>> + if {$lenrecent > 0} {
>>  if {$m_repo ne {}} {
>>  $m_repo add separator
>>  $m_repo add command \
>> @@ -153,7 +154,7 @@ constructor pick {} {
>>  -background [get_bg_color $w_body.recentlabel] \
>>  -wrap none \
>>  -width 50 \
>> - -height $maxrecent
>> + -height $lenrecent
>>  $w_recentlist tag conf link \
>>  -foreground blue \
>>  -underline 1
>
> Natural questions that come to mind after seeing the above are like
> these:
>
> - Does maxrecent still get used after this change?

Yes, essentially as you describe....

>
> - Does the remainder of the code get upset if -height is set to too
>   small (lenrecent might turn out to be 1, for example)?

No it's OK, the code has at least checked it is positive..

>
> And grepping for maxrecent shows there is _append_recentrepos that
> does this:

It does three things:
- removes the current (selected) repo from the list of past repos (and 
removes any duplicates)
- places the current repo at the end
- trims the list to back to max repos.

Nominally, it can't do anything about non-selected valid repos which may be 
listed in the config twice because git config won't selectively remove just 
one of two identical key/values, however in Patch 3 I do remove both older & 
newer entries and re-read the config (some may consider that a small 
regression).

It's not easy working around the contrary assumptions of the gui.recentrepo 
list (once only) and the reality of the .gitconfig (duplicates possible) and 
'git config's --unset/--unset-all limitation.

Exactly how those extra entries get there is an open question, but it does 
happen (so say's google, as well as the user report, I've seen it myself ;-)

>
> proc _append_recentrepos {path} {
> set path [file normalize $path]
> set recent [get_config gui.recentrepo]
>
> ...
> if {[set maxrecent [get_config gui.maxrecentrepo]] eq {}} {
> set maxrecent 10
> }
>
> while {[llength $recent] > $maxrecent} {
> _unset_recentrepo [lindex $recent 0]
> set recent [lrange $recent 1 end]
> }
> }
>
> The last while loop looks to me like truncating the overlong recent
> list down to maxrecent.

Yes

>   Perhaps a similar logic needs to be at the
> end of _get_recentrepos?

The logic here is to show what is in the config to the user, *before* we 
trim the list, hence we wait until the user has selected a repo to open and 
do the purging in _append_recentrepos.

As an aside, there's also a long standing 'feature' that if one works both 
on and off network, then network repo paths get trimmed as soon as the user 
starts the gui while off-net (or the network goes down;-) because those 
recent repo paths become 'invalid' and are purged, but let's not go there.

--
Philip 
