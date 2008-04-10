From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 8/8] Fix tests breaking when checkout path contains	shell
 metacharacters
Date: Thu, 10 Apr 2008 08:49:03 +0200
Message-ID: <47FDB85F.9070503@viscovery.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <1207704604-30393-3-git-send-email-bdonlan@fushizen.net> <1207704604-30393-4-git-send-email-bdonlan@fushizen.net> <1207704604-30393-5-git-send-email-bdonlan@fushizen.net> <1207704604-30393-6-git-send-email-bdonlan@fushizen.net> <1207704604-30393-7-git-send-email-bdonlan@fushizen.net> <1207704604-30393-8-git-send-email-bdonlan@fushizen.net> <47FC69B8.40809@viscovery.net> <20080410063028.GA12562@shion.is.fushizen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Adam Roben <aroben@apple.com>,
	Junio C Hamano <gitster@pobox.com>
To: Bryan Donlan <bdonlan@fushizen.net>
X-From: git-owner@vger.kernel.org Thu Apr 10 08:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjqbm-0002S5-7D
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 08:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109AbYDJGtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 02:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753130AbYDJGtW
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 02:49:22 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35740 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbYDJGtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2008 02:49:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jjqal-0006a9-Gg; Thu, 10 Apr 2008 08:49:03 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3F1C96C4; Thu, 10 Apr 2008 08:49:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080410063028.GA12562@shion.is.fushizen.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79171>

Bryan Donlan schrieb:
> (did you mean to send the original reply to the list as well? not ccing for
>  now, feel free to re-send/forward to the list if you like)

Sorry, yes, I hit the wrong button. I'm lazy again and simply resend this
reply with the complete Cc list, with everything quoted.

> On Wed, Apr 09, 2008 at 09:01:12AM +0200, Johannes Sixt wrote:
>> Bryan Donlan schrieb:
>>> -		GIT_WORK_TREE=$(pwd) GIT_DIR=git-dir-wt-1.git git init
>>> +		GIT_WORK_TREE="$(pwd)" GIT_DIR=git-dir-wt-1.git git init
>> This ...
>>
>>> -HERE=`pwd`
>>> +HERE="$(pwd)"
>> ... and this and a lot of similar cases shouldn't be required: The RHS of
>> an assignment does not undergo word-splitting.
> 
> Will fix.
> 
>>> -export GIT_DIR=$(pwd)/repo.git
>>> -export GIT_CONFIG=$GIT_DIR/config
>>> +export GIT_DIR="$(pwd)/repo.git"
>>> +export GIT_CONFIG="$GIT_DIR/config"
>> This, OTOH, is not an assignment, and the change is to the better. But not
>> all shells support export with assignment. Hence this should be changed to
>> the form
>>
>> 	GIT_DIR=$(pwd)/repo.git
>> 	GIT_CONFIG=$GIT_DIR/config
>> 	export GIT_DIR GIT_CONFIG
>>
>> (and similar cases at other places).
> 
> I'll break these bits out into another patch in the sequence and fix.
> 
>>>  test_expect_success  ".rev_db auto-converted to .rev_map.UUID" "
>>>  	git-svn fetch -i trunk &&
>>> -	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
>>> -	expect=\"\$(ls $GIT_DIR/svn/trunk/.rev_map.*)\" &&
>>> +	test -z \"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_db.* 2>/dev/null)\" &&
>>> +	expect=\"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_map.*)\" &&
>>>  	test -n \"\$expect\" &&
>>> -	rev_db=\$(echo \$expect | sed -e 's,_map,_db,') &&
>>> -	convert_to_rev_db \$expect \$rev_db &&
>>> -	rm -f \$expect &&
>>> -	test -f \$rev_db &&
>>> +	rev_db=\"\$(echo \$expect | sed -e 's,_map,_db,')\" &&
>>> +	convert_to_rev_db \"\$expect\" \"\$rev_db\" &&
>>> +	rm -f \"\$expect\" &&
>>> +	test -f \"\$rev_db\" &&
>>>  	git-svn fetch -i trunk &&
>>> -	test -z \"\$(ls $GIT_DIR/svn/trunk/.rev_db.* 2>/dev/null)\" &&
>>> -	test ! -e $GIT_DIR/svn/trunk/.rev_db &&
>>> -	test -f \$expect
>>> +	test -z \"\$(ls \"\$GIT_DIR\"/svn/trunk/.rev_db.* 2>/dev/null)\" &&
>>> +	test ! -e \"\$GIT_DIR\"/svn/trunk/.rev_db &&
>>> +	test -f \"\$expect\"
>>>  	"
>> While looking at this test: Wouldn't it be easier to just place the whole
>> thing (and probably similar cases, too) in single-quotes?
> 
> To be honest, I fixed all the git-svn tests with a suitably clever vim s///
> expression, so at the time this way was actually easier :)

Fair enough. If you still have the statement in you vim history, it's
worth quoting in the commit message. It's another piece of information
that helps reviewing.

> (Essentially all of the git-svn tests were broken, and it was a little
>  annoying to fix them all by hand... though of course I verified the
>  results)

-- Hannes
