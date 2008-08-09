From: Tarmigan <tarmigan+git@gmail.com>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b' was omitted
Date: Sat, 9 Aug 2008 14:56:19 -0700
Message-ID: <905315640808091456q63c20dcfp9ab3b93387688693@mail.gmail.com>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org>
	 <7vvdya55ur.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 09 23:57:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRwRA-0002IE-EE
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 23:57:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbYHIV4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 17:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbYHIV4W
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 17:56:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:31045 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbYHIV4V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 17:56:21 -0400
Received: by nf-out-0910.google.com with SMTP id d3so542781nfc.21
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 14:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=wQa2r4LOXSkf+hEUHnxGaTIR85Dvl7NTmMoozNZDnnk=;
        b=NVNooWsQ252B+IwnEo/UGgq4SuIj9yaI0d+mWXyC0sqtXWzFgVd0GI+aFIbhneLXlf
         9lp/DEoYozRfUxKZtL7NyPfsh2Tx2FlZRbFAZwGKjDmOM2N7nkhGWPJnqTbhwSvW9+SK
         vssRNBD0JGnNGoyDKzT5VnBdA3vTJggnE8NtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=opQS81g6yOha3VxSFxYlYHN6pU5vvbbkjVZ3aDSpj2VHD5mGv8ZNVbsI1goKmw2jYv
         +cvWPBKJnNxar7Q5JNKAbw6PbkJkCt8K8wHuA9jMQcIAEuPRFpcqYEJRWhYucYUCjbng
         w/mAK8ww6ap/wsukwbSv7Gtx/hH/KPQaPjhO8=
Received: by 10.210.120.7 with SMTP id s7mr7393067ebc.76.1218318979681;
        Sat, 09 Aug 2008 14:56:19 -0700 (PDT)
Received: by 10.210.109.18 with HTTP; Sat, 9 Aug 2008 14:56:19 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
X-Google-Sender-Auth: f0d1bd114b027df8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91786>

On Sat, Aug 9, 2008 at 2:08 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 9 Aug 2008, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >
>> >> What does the user most likely want with this command?
>> >>
>> >>    $ git checkout --track origin/next
>> >>
>> >> Exactly.  A branch called 'next', that tracks origin's branch 'next'.
>> >
>> > I like this.
>> >
>> > An explicit --track request from the command line (as opposed to
>> > happening to have "branch.autosetupmerge" configuration) is a very
>> > good cue that what the user wants to do is not to take a peek on a
>> > detached HEAD but a more permanent playpen created.
>>
>> A couple more thoughts.
>
> At first, I liked the thoughts, but...
>
>> (1) You may not necessarily are used to --track, but may still want this
>>     done.  It might not be a bad idea to associate this "local dwimming"
>>     to creation of a new branch.  In other words, all of these:
>>
>>     $ git checkout -b origin/next
>
> This cannot be dwimmed, as it literally means "start a new branch called
> 'origin/next' from HEAD".

Could we check whether there is already a remote called "origin" with
a branch called "next"?  If refs/remotes/origin/next exists it could
be confusing to create refs/heads/origin/next anyway, so it this dwim
might eliminate a problem as well as be nicer.  In fact, git soon
complains (rightly) about ambigiuos references in this case.

> So it would change the current behavior would, breaking people's habits (I
> do "git checkout -b bla" a lot when I realize that I want to have the
> current changes on a new branch).

If we did this dwim only for remotes, your desired behavior could
still work, right?.  The default is to --track for branches created
from remotes anyway, right?

Thanks,
Tarmigan
