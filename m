From: greened@obbligato.org
Subject: Re: [PATCH 3/8] Better Error Handling for add
Date: Tue, 01 Jan 2013 16:33:53 -0600
Message-ID: <87obh8fs8e.fsf@waller.obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
	<1357012655-24974-4-git-send-email-greened@obbligato.org>
	<7v1ue4a8i0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 23:35:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqAQD-00014T-30
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 23:34:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367Ab3AAWei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 17:34:38 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48601 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751327Ab3AAWeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 17:34:37 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1TqAX1-0001GC-0x; Tue, 01 Jan 2013 16:41:59 -0600
In-Reply-To: <7v1ue4a8i0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 Jan 2013 13:39:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Junio C Hamano <gitster@pobox.com> writes: >> diff --git a/contrib/subtree/git-subtree.sh
    b/contrib/subtree/git-subtree.sh >> index 7ceb413..b8a807a 100755 >> ---
   a/contrib/subtree/git-subtree.sh >> +++ b/contrib/subtree/git-subtree.sh >>
    @@ -509,8 +509,20 @@ cmd_add() >> ensure_clean >> >> if [ $# -eq 1 ]; then
    >> + ref=$(git check-ref-format --normalize "refs/heads/$1") || >> + die
   "'$1' is not a valid refspec. Are you missing a branch?" > > Is a user forbidden
    from passing a commit that is not at the tip of > an exist 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212465>

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 7ceb413..b8a807a 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -509,8 +509,20 @@ cmd_add()
>>  	ensure_clean
>>  	
>>  	if [ $# -eq 1 ]; then
>> +	        ref=$(git check-ref-format --normalize "refs/heads/$1") ||
>> +                die "'$1' is not a valid refspec.  Are you missing a branch?"
>
> Is a user forbidden from passing a commit that is not at the tip of
> an existing branch?  In other words, is
>
> 	$ subtree add origin/next~4^2
>
> forbidden?

Good point.  It probably shouldn't be.  I think rev-parse should be
enough of a check.

>> +	        rev=$(git rev-parse --verify $1) ||
>> +                die "'$1' is not a valid refspec.  Are you missing a branch?"
>> +
>>  		"cmd_add_commit" "$@"
>
> If you want to make sure you give a comit to add_commit, you can
> probably say something like this:
>
> 	git rev-parse -q --verify "$1^{commit}" >/dev/null ||
>         die "'$1' does not refer to a commit"

What does $1^{commit} mean?  I think your suggestion is what I want but
I don't know what it means yet.  :)

                           -David
