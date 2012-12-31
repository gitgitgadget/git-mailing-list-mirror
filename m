From: greened@obbligato.org
Subject: Re: [PATCH] subtree.sh: Use raw subject and body modifier "%B" instead of "%s%n%n%b"
Date: Mon, 31 Dec 2012 16:57:27 -0600
Message-ID: <87mwwt4yp4.fsf@waller.obbligato.org>
References: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
	<1344561358-2953-2-git-send-email-techlivezheng@gmail.com>
	<87zk5pdn43.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, apenwarr@gmail.com
To: Techlive Zheng <techlivezheng@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 00:15:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpoZe-0003a3-4e
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 00:15:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849Ab2LaXOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 18:14:55 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48185 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774Ab2LaXOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 18:14:53 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TpoQ6-0004xC-UI; Mon, 31 Dec 2012 17:05:23 -0600
In-Reply-To: <87zk5pdn43.fsf@waller.obbligato.org> (greened@obbligato.org's
	message of "Mon, 20 Aug 2012 20:56:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  greened@obbligato.org writes: > Techlive Zheng <techlivezheng@gmail.com>
    writes: > >> "%s%n%n%b" is not always equal to "%B". If the commit msg does
    not have >> a body, this will append an extra new-line character to the msg
    title >> which would cause the splited commit has a new sha1 hash. In most
    cases, >> this does not matter, but for a project which did not merged using
    this >> script initially, the 'split' command would not genereate the same
    >> commits as the orginal which may cause conflicts. >> >> Signed-off-by 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212366>

greened@obbligato.org writes:

> Techlive Zheng <techlivezheng@gmail.com> writes:
>
>> "%s%n%n%b" is not always equal to "%B". If the commit msg does not have
>> a body, this will append an extra new-line character to the msg title
>> which would cause the splited commit has a new sha1 hash. In most cases,
>> this does not matter, but for a project which did not merged using this
>> script initially, the 'split' command would not genereate the same
>> commits as the orginal which may cause conflicts.
>>
>> Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
>> ---
>>  contrib/subtree/git-subtree.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 920c664..5598210 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -296,7 +296,7 @@ copy_commit()
>>  	# We're going to set some environment vars here, so
>>  	# do it in a subshell to get rid of them safely later
>>  	debug copy_commit "{$1}" "{$2}" "{$3}"
>> -	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
>> +	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
>>  	(
>>  		read GIT_AUTHOR_NAME
>>  		read GIT_AUTHOR_EMAIL
>
> This looks good to me.  I assume this passes all the tests.  Can you add
> a test for this bug so we don't regress?  Junio, I am good with this
> patch as soon as we get a test for the problem.

I've applied this patch to my working copy but I'm not finding that I
can recreate the original problem when the patch is disabled.

I assumed the scenario you're trying to fix is:

- Make some commit C to project A with a one-line message
- work, commit, work...
- Add project A as a subproject
- work, commit, work...
- Split project A off into a separate repository

After this, commit C with the one-line message in the split-off projet
should have the same hash it had before project A was incorporated as a
subproject.

As I understad it, you saw the post-split commit having a different
hash?

Is that right?  I am not seeing that problem even without your patch.

I want to make sure I understand what the problem is so I can test for
it.

Thanks!

                      -David
