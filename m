From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 20:27:58 +0100
Message-ID: <554BBCBE.1020408@diamand.org>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>	<1431019501-30807-3-git-send-email-luke@diamand.org> <xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 21:28:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqRTN-00028Z-3o
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 21:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbbEGT2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 15:28:36 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35263 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbbEGT2g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 15:28:36 -0400
Received: by widdi4 with SMTP id di4so3676177wid.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ueKM9oAGw/5TlHo2pbWt8sCPyxLdRfnXIkDVJKPQ3y8=;
        b=gziYjFa7G1JJC/B/k2/q5BQbHPmGokBOUCw47K83+Lkq43bhQqM03m9Zi0+52G0E+b
         o6ChxV2yL3JXqJakdiO2edH3opOTLH2zlq1opV7Z+U/XLuad3tiAOS+FoU6s4dwY1d6C
         xxLPytuF3DFEm3eWt8f1vEt475eAFGtG9023U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=ueKM9oAGw/5TlHo2pbWt8sCPyxLdRfnXIkDVJKPQ3y8=;
        b=dOWmeJnL31tz0ELKzZynoFuvFnlMabqrPyGt7HyNS+E3QWn2iaEhji6mlHVTVyHJxn
         3q0kEBIPvR1fKN8oEp+k35E+Wg/clbfhhAy9zvN5FCbE+OQfFioEZ7E6hN7ZAB2oF63a
         +VPnLI+KAHz+nWdSJstJLT+zDsqXv2+YWZbA+oB7zHOaiOQL3M7RGYtLOKGXwcnrF+lC
         gMYsmYKWF10EFvN8IWiI70U209AzyAy1JMHZFbJPlGA+kR3nvNvFJEv+5esckbuVZSjH
         gG852/MpR21qxJpR1JGo5fEPnsFQkkc6BHE6D1/XDASfoA2Xag1/AulMwmxJWf1od2qI
         BElw==
X-Gm-Message-State: ALoCoQkdY+cxi1x0/r+0EL9/iSiSc2nvDgDeMRUtr1maQlFS2r7JRqUCoQ4Aj4VXkrZykKBVOm1D
X-Received: by 10.194.97.196 with SMTP id ec4mr325487wjb.3.1431026914914;
        Thu, 07 May 2015 12:28:34 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id y7sm4903798wjw.16.2015.05.07.12.28.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2015 12:28:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268583>

On 07/05/15 19:11, Junio C Hamano wrote:
> Luke Diamand <luke@diamand.org> writes:
>
>
> Does the real Perforce, when spawning P4EDITOR, behave the same way?
>
> If not, this patch would be breaking not just the expectation of
> existing git-p4 users (which we cannot avoid and which we are
> willing to do) but also breaking things for people who _will_ come
> to us in the future, expecting that
>
> 	export P4EDITOR="/Users/me/My Programs/my-editor"
>
> to work as they expect.  If they already have to do
>
> 	export P4EDITOR="'/Users/me/My Programs/my-editor'"
>
> then there is no problem, but because I am not a P4EDITOR user, I am
> merely double checking.

On Linux:

$ export P4EDITOR="gvim -f"
$ p4 submit
-- works as you would hope --

$ export P4EDITOR="/home/lgd/My Programs/editor.sh"
$ p4 submit
sh: 1: /home/lgd/My: not found

$ export P4EDITOR="/home/lgd/My\ Programs/editor.sh"
-- works fine --

I don't know what happens on Windows. But I think the "sh -c" code would 
break on that platform, whereas the current code works fine (*)

Luke


(*) I should probably get a Windows test environment going somehow so I 
can check this stuff.

>
>>
>> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Luke Diamand <luke@diamand.org>
>> ---
>>   git-p4.py                         | 2 +-
>>   t/t9820-git-p4-editor-handling.sh | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index 41a77e6..ca6bb95 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -1248,7 +1248,7 @@ class P4Submit(Command, P4UserMap):
>>               editor = os.environ.get("P4EDITOR")
>>           else:
>>               editor = read_pipe("git var GIT_EDITOR").strip()
>> -        system([editor, template_file])
>> +        system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
>>
>>           # If the file was not saved, prompt to see if this patch should
>>           # be skipped.  But skip this verification step if configured so.
>> diff --git a/t/t9820-git-p4-editor-handling.sh b/t/t9820-git-p4-editor-handling.sh
>> index e0a3c52..c178bd7 100755
>> --- a/t/t9820-git-p4-editor-handling.sh
>> +++ b/t/t9820-git-p4-editor-handling.sh
>> @@ -17,9 +17,9 @@ test_expect_success 'init depot' '
>>   	)
>>   '
>>
>> -test_expect_failure 'EDITOR has options' '
>>   # Check that the P4EDITOR argument can be given command-line
>>   # options, which git-p4 will then pass through to the shell.
>> +test_expect_success 'EDITOR has options' '
>>   	git p4 clone --dest="$git" //depot &&
>>   	test_when_finished cleanup_git &&
>>   	(
