From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v3] peel_onion(): add support for <rev>^{tag}
Date: Tue, 03 Sep 2013 15:39:41 -0400
Message-ID: <52263AFD.3060308@bbn.com>
References: <1378229853-21236-1-git-send-email-rhansen@bbn.com> <CAPig+cRQP5CGz_1ckf5Qr6HcB+OvWHNPtGQ8RxWdqTZK0fRo2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 21:39:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwSB-0000AD-7r
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 21:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760272Ab3ICTjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 15:39:49 -0400
Received: from smtp.bbn.com ([128.33.1.81]:58424 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab3ICTjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 15:39:48 -0400
Received: from socket.bbn.com ([192.1.120.102]:59547)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VGwRx-000Knv-LF; Tue, 03 Sep 2013 15:39:41 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 52ABC3FF72
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <CAPig+cRQP5CGz_1ckf5Qr6HcB+OvWHNPtGQ8RxWdqTZK0fRo2w@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233765>

On 2013-09-03 15:03, Eric Sunshine wrote:
> On Tue, Sep 3, 2013 at 1:37 PM, Richard Hansen <rhansen@bbn.com> wrote:
>> diff --git a/t/t1511-rev-parse-caret.sh b/t/t1511-rev-parse-caret.sh
>> index eaefc77..5771cbd 100755
>> --- a/t/t1511-rev-parse-caret.sh
>> +++ b/t/t1511-rev-parse-caret.sh
>> @@ -54,6 +61,26 @@ test_expect_success 'ref^{tree}' '
>>         test_must_fail git rev-parse blob-tag^{tree}
>>  '
>>
>> +test_expect_success 'ref^{tag}' '
>> +       echo $BLOB_TAG_SHA1 >expected &&
>> +       git rev-parse --verify blob-tag^{tag} >actual &&
>> +       test_cmp expected actual &&
>> +       echo $TREE_TAG_SHA1 >expected &&
>> +       git rev-parse --verify tree-tag^{tag} >actual &&
>> +       test_cmp expected actual &&
>> +       echo $COMMIT_TAG_SHA1 >expected &&
>> +       git rev-parse --verify commit-tag^{tag} >actual &&
>> +       test_cmp expected actual &&
>> +       echo $TAG_TAG_SHA1 >expected &&
>> +       git rev-parse --verify tag-tag^{tag} >actual &&
>> +       test_cmp expected actual &&
>> +       test_must_fail git rev-parse --verify $BLOB_SHA1^{tag} &&
>> +       test_must_fail git rev-parse --verify $TREE_SHA1^{tag} &&
>> +       test_must_fail git rev-parse --verify $COMMIT_SHA1^{tag} &&
>> +       test_must_fail git rev-parse --verify rev^{tag} &&
>> +       true
>> +'
> 
> The unnecessary trailing "&& true" is unusual. Such form is not used
> elsewhere in this file, or in any script in the test suite.

True.  I can take it out, and while I'm at it simplify the test case to
what Peff suggested.

I'm in the habit of using that idiom because (1) I won't break things if
I forget to add/remove '&&' when I add/remove lines in a future commit,
and (2) it simplifies conflict resolution if two commits touch the same
list of stuff.

-Richard
