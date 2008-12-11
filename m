From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Clarifying "invalid tag signature file" error message from git
 filter-branch (and others)
Date: Thu, 11 Dec 2008 17:13:36 -0600
Message-ID: <LhfS_uc2B_Gje7rXd1882RMsQfSRjOEsBT24Z1Yza_bWhgl9lI-ZhQ@cipher.nrlssc.navy.mil>
References: <c5df85930812110214k2e12d926m60856fb630d45e80@mail.gmail.com> <P7E-5meNX4tXFurN9mnRguFHdJG1jaZYTn6WxFFpECSJ68KyYT3wqQ@cipher.nrlssc.navy.mil> <c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: James Youngman <jay@gnu.org>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAukH-0004QF-Ci
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 00:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757588AbYLKXNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 18:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756611AbYLKXNm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 18:13:42 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:33654 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbYLKXNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 18:13:42 -0500
Received: by mail.nrlssc.navy.mil id mBBNDaB6014916; Thu, 11 Dec 2008 17:13:36 -0600
In-Reply-To: <c5df85930812111434m879f1faq80c64286714c3a1f@mail.gmail.com>
X-OriginalArrivalTime: 11 Dec 2008 23:13:36.0493 (UTC) FILETIME=[184AC9D0:01C95BE6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102839>

James Youngman wrote:
> On Thu, Dec 11, 2008 at 9:06 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> James Youngman wrote:
>>> What do the errors "error: char88: malformed tagger field" and "fatal:
>>> invalid tag signature file" and "Could not create new tag object for
>>> FINDUTILS-4_1-10" signify in the session below?
>> It means the tagger field in the tag does not follow the correct form.
>> Specifically the testing in git-mktag (called by filter-branch) does:
>>
>>         * Check for correct form for name and email
>>         * i.e. " <" followed by "> " on _this_ line
>>         * No angle brackets within the name or email address fields.
>>         * No spaces within the email address field.
>>
>> What does 'git cat-file tag FINDUTILS-4_1-10' show you?
> 
> Before conversion:
> $ git cat-file tag FINDUTILS-4_1-10
> object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
> type commit
> tag FINDUTILS-4_1-10
> tagger Kevin Dalley

The tagger field is missing an email address, a timestamp, and a timezone. It
should look something like:

  tagger Kevin Dalley <kevin.dalley@somewhere.com> 1229036026 -0800

git-mktag prevents improperly formatted tags from being created by checking
that these fields exist and are well formed.

If you know the correct values for the missing fields, then you could
recreate the tags before doing the filter-branch. If they are unknown, it
seems valid enough to use the values from the commit that the tag points
to.

i.e.

  tagger Kevin Dalley <kevin@seti.org> 830638152 -0000

What tool was used to convert this repository to git? It should be corrected
to produce valid annotated tags. Especially if it is a tool within git.


The tag below was actually not converted. filter-branch bailed
out during the conversion and so left it alone.

> The conversion:
> 
> After conversion:
> $ git cat-file tag FINDUTILS-4_1-10
> object ce25eb352de8dc53a9a7805ba9efc1c9215d28c2
> type commit
> tag FINDUTILS-4_1-10
> tagger Kevin Dalley
> 
> This is in the repo at
> http://git.savannah.gnu.org/gitweb/?p=findutils.git;a=commit;h=ce25eb352de8dc53a9a7805ba9efc1c9215d28c2

-brandon
