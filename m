From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Resumable git clone?
Date: Thu, 24 Mar 2016 21:08:53 -0000
Organization: OPDS
Message-ID: <211C0A1532414ED79933D75741AB26A0@PhilipOakley>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com><xmqqziuh46hb.fsf@gitster.mtv.corp.google.com><C59B0CDA60BC402B900305A9D62D815B@PhilipOakley> <xmqqy497an4a.fsf@gitster.mtv.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Josh Triplett" <josh@joshtriplett.org>,
	"Konstantin Ryabitsev" <konstantin@linuxfoundation.org>,
	"Git List" <git@vger.kernel.org>, <sarah@thesharps.us>,
	<viro@zeniv.linux.org.uk>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 22:09:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajCV2-0006jm-VW
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 22:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbcCXVI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 17:08:57 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:4864 "EHLO
	smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbcCXVI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 17:08:56 -0400
Received: from PhilipOakley ([92.22.6.252])
	by smtp.talktalk.net with SMTP
	id jCUtabcMcCrtejCUta9mYX; Thu, 24 Mar 2016 21:08:53 +0000
X-Originating-IP: [92.22.6.252]
X-Spam: 0
X-OAuthority: v=2.1 cv=L/e9O7n8 c=1 sm=1 tr=0 a=L1JPMP/96Cd0ZXeOJ41CKA==:117
 a=L1JPMP/96Cd0ZXeOJ41CKA==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8
 a=zBK5yZjOAAAA:8 a=hKWDOzQ4MoXv2wer9D4A:9 a=wPNLvfGTeEIA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfDh5G2tmghVLpmDc8Hc2MztYxdMr33lj4Mp9OJeYijfIEcw2NBau84VcHXyrZdlXsrnUYT4dTEPXvD4Xfwwi9pk42c3KVPYslSFfXEJ/+UxgrSMNQ6F/
 QQx5KpQFU+XNAgMKENYF+J85lKb/T3LrCQiH5AduFUPuboqKJtiuPXyFYQiOdV7s3iHgRr4soM2ArkOwJkyvLeJNu4R4Xb+f99Rn7ZHGcCajBBFUo4KhzxsZ
 A4VlRvLhUZusDPQ4ocFAoRk7j79+DqBlIVMEedrYXl/bEHXwL+3x5i9o4B9qFtPcN89KjAy0YVs9dlJMqbH+rj58IsCCg02BSBLzPDcTEko=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289798>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>>
>>>> If you clone a repository, and the connection drops, the next attempt
>>>> will have to start from scratch.  This can add significant time and
>>>> expense if you're on a low-bandwidth or metered connection trying to
>>>> clone something like Linux.
>>>
>>> For this particular issue, your friendly k.org administrator already
>>> has a solution.  Torvalds/linux.git is made into a bundle weekly
>>> with
>>>
>>>    $ git bundle create clone.bundle --all
>>>
>>> and the result placed on k.org CDN.  So low-bandwidth cloners can
>>> grab it over resumable http, clone from the bundle, and then fill
>>> the most recent part by fetching from k.org already.
>>
>> Isn't this use of '--all' a bit of oversharing?
>
> Not for the exact use case mentioned; k.org administrator knows what
> is in Linus's repository and is aware that there is no remote-tracking
> branches or secret branches that may make the resulting bundle unsuitable
> for priming a clone.

OK
>
>> " I also think "--all" is a bad advice for another reason.
>
> I do not think it is a good advice for everybody, but the thing is,
> what you are responding is not an advice.  It is just a statement of
> a fact, what is already done, one of the existing practices that an
> approach to "resumable clone" may want to help.
>
I was picking up on the need, for others who maybe generating clone bundles, 
that '--all' may not be the right thing for them, and that somewhere we 
should record whatever is deemed the equivalent of the current clone 
command. This would get away from the web examples which show '--all' as a 
quick solution for bundling (I'm one of the offenders there).

If I understand the clone code, the  rev-list-args would be 
"HEAD --branches". But I could well be wrong.
--
Philip 
