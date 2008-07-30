From: "Alexander Gavrilov" <angavrilov@gmail.com>
Subject: Re: [PATCH v2] Support copy and rename detection in fast-export.
Date: Wed, 30 Jul 2008 13:10:07 +0400
Message-ID: <bb6f213e0807300210r205846b4qffa9fc71d4aa6533@mail.gmail.com>
References: <200807211216.01694.angavrilov@gmail.com>
	 <200807262249.18005.angavrilov@gmail.com>
	 <20080726202103.GA15769@spearce.org>
	 <200807270052.55370.angavrilov@gmail.com>
	 <7v7ib4hdpu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 11:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO7iC-0007CA-BJ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 11:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773AbYG3JKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 05:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbYG3JKK
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 05:10:10 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:53433 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYG3JKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 05:10:09 -0400
Received: by mu-out-0910.google.com with SMTP id w8so481154mue.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 02:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nPa0xAGp+dpbNgiutn/Tb3++42Xs+JPufGe0/XsrqRE=;
        b=UncbQrFlai4LaAsJpiG7CyiPAuolo9NdSnm6ufBqTAIPB5IIYFqMf7lqzdYmMDa8SF
         DP6BlNdrliA9f2TQ/UkJ2WanVG2JCn4hjqZWvoXtdw6Xts0CvzQB32hkWjmH1lKJQm3M
         rTMdZKK2uAdrA6dOfTaSJrJiNyjKLfcnrSU6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Hvqq3MzxlXYp3fjQIBIwxdQApc99WsZevbv84nIqtcw7yLmqc3x9k49wlqo9jA7V0Q
         KxltAMrg9yuDftgiXPV1orZPIaRIe1sXJWB4R9UPB34FubDToJTEbys2aqZXk2pEuGtz
         ERUxgG+NK/dx0LgcIq/KGqFuRLjgD0U4uzdIU=
Received: by 10.103.247.5 with SMTP id z5mr3562405mur.31.1217409007475;
        Wed, 30 Jul 2008 02:10:07 -0700 (PDT)
Received: by 10.103.251.10 with HTTP; Wed, 30 Jul 2008 02:10:07 -0700 (PDT)
In-Reply-To: <7v7ib4hdpu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90759>

On Tue, Jul 29, 2008 at 8:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Alexander Gavrilov <angavrilov@gmail.com> writes:
>> ++
>> +Note that these options were always accepted by git-fast-export,
>> +but before a certain version it silently produced wrong results.
>> +You should always check the git version before using them.
>> +
>
> I do not quite follow the mention of "before a certain version", but I
> think it is talking about the earlier "fast-export" that took any diff
> options but did not act differently upon renamed/copied entries.  If that
> is the case, I think we can say something like this instead:
>
>        Note that earlier versions of this command did not complain and
>        produced incorrect results if you gave these options.
>
> because docs always talk about the current version.  My reading of Dscho's
> original 'show_filemodify' suggests me that "wrong results" does not just
> mean missing rename/copy information but a renamed old entity did not get
> removed correctly, resulting in an incorrect tree in the commit, right?
> Maybe we would want to be a bit more explicit about what kind of breakage
> you are talking about here.

Yes, broken renames is what I've been thinking of when I wrote that.

As fast-export is mainly meant to be used by third-party conversion
scripts, which are not bundled together with git, unsuspecting users
might try to run them using an old git version. The main point of my
note is that scripts should always check the version if they want to
use these options. It probably should also specify the exact value to
compare to, e.g:

        Note that before git 1.6 this command did not complain and produced
        incorrect results if you gave these options. Your scripts should always
        check the version before using them.


> If you see a copied or renamed entry, you emit "this old path to that old
> path" first, and then say that same path got modified.  It appears from my
> quick glance of fast-import that touching the same path more than once in
> a same commit like this sequence does would work fine (it will involve two
> calls to tree_content_set() for the same path but that is not something it
> has to forbid, and the function doesn't).

I'm sorry, but I don't quite understand what are you suggesting by
this paragraph. Yes, fast-import understands double modification, and
my test includes a check for this case. Of course, conversion scripts
for dumber targets might need to do one-line lookahead to eliminate
non-100% copies.


>> diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
>> index f18eec9..bb595b7 100755
>> --- a/t/t9301-fast-export.sh
>> +++ b/t/t9301-fast-export.sh
>> @@ -162,4 +162,50 @@ test_expect_success 'submodule fast-export | fast-import' '
>>
>>  '
>>
>> +export GIT_AUTHOR_NAME='A U Thor'
>> +export GIT_COMMITTER_NAME='C O Mitter'
>> +
>> +test_expect_success 'setup copies' '
>> +
>> +     git config --unset i18n.commitencoding &&
>
> These are somewhat unusual.  Was there any reason for these exports and
> config?
>

t9301-fast-export.sh earlier changes these parameters to test
automatic conversion to utf8. I reset them back before my test, in
order to be able to test the import by comparing SHA-1 (encoding
conversion changes it). There may be a better way to do it, though.
