From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Tue, 9 Jun 2009 21:28:25 +0200
Message-ID: <c07716ae0906091228s708058d4vea986239a6b458de@mail.gmail.com>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	 <7vskidcf9s.fsf@alter.siamese.dyndns.org>
	 <200906070932.36913.chriscool@tuxfamily.org>
	 <4A2CAA56.1030707@zytor.com> <7vws7n6vcf.fsf@alter.siamese.dyndns.org>
	 <4A2D337C.70203@zytor.com> <7vzlcixwue.fsf@alter.siamese.dyndns.org>
	 <c07716ae0906082124n4a5bfe88md80ba8076c928b76@mail.gmail.com>
	 <c07716ae0906090526i714bb6c9g4e3d8cf61021af77@mail.gmail.com>
	 <4A2E7EEC.2050807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>,
	Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:28:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ME6zu-0003Ys-QS
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 21:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756549AbZFIT22 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 15:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752029AbZFIT21
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 15:28:27 -0400
Received: from mail-fx0-f213.google.com ([209.85.220.213]:48097 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbZFIT20 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 15:28:26 -0400
Received: by fxm9 with SMTP id 9so249103fxm.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 12:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i9Nu4yeqipTTguLEFs/hZeCB/bxxA87XZmH9+sLeLgo=;
        b=w7D+gd8qwjOcdDEhLybPUalZxhpC4Uj3DOlQtnWMAa+RXC5Hio448Wa22wPS0MhslT
         Z9M6Z14WdFwFZWkuNxBG4e3+o5czxWLQgNd8ncN+5nBkautA2M69Q+2KTosGs7X+FePm
         zggAq69kWksTBi/B8qmYqXvf2NiROxK+IWGsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bzJ3lIMwX/MIT97Y+mYdVfObirBrdRyv5+8qwwrubjkXnTPefXIGvgsrIVPCgbmz32
         ZdiAcMyumvpFLewd/MjoTj1Fjeh29J5VxyCe8rTv4rgAxySPor0FkSlPClrjVhhyOcFy
         n41no7E1SQzEanVbJFcuI5CKoTewh+Qo6ibRY=
Received: by 10.103.182.3 with SMTP id j3mr288866mup.135.1244575705114; Tue, 
	09 Jun 2009 12:28:25 -0700 (PDT)
In-Reply-To: <4A2E7EEC.2050807@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121209>

On Tue, Jun 9, 2009 at 5:25 PM, H. Peter Anvin<hpa@zytor.com> wrote:
> Christian Couder wrote:
>> On Tue, Jun 9, 2009 at 6:24 AM, Christian
>> Couder<christian.couder@gmail.com> wrote:
>>> So I would be ok to implement a config option or a switch to "git
>>> bisect start" to let people use a PRNG instead of my algorithm but I
>>> think something like my algorithm should be the default.
>>
>> Another reason to have 2 algorithms is that when you use "git bisect
>> run" you might want to use the PRNG one because:
>>
>> - you don't care much if the bisection use some more steps (as long as
>> it does not get stuck)
>> - you can't do much if it get stuck
>>
>> On the other hand, when you bisect manually:
>>
>> - you probably won't like it if you are asked to test some commits
>> that won't give a lot of information
>> - if it get stuck, you can manually use "git bisect visualize" and/or
>> "git bisect skip <range>" and/or some other manual commands to do
>> something about it
>>
>
> Sort-of-kind-of.  I doubt most users will be able to recover from a
> stuck situation, and unless we have extremely high cost of testing
> (which is true for some applications) then expecting the user to
> optimizing manually is really bad user design.

My opinion is that we should not penalize all the people working on
"quite clean" projects and also people working on "not clean" projects
who are able to recover, on the pretence that there are other people
on these "not clean" projects who are not.

I think it's the projects maintainers' responsibility to keep their
projects graphs quite clean (and they have the right to ask git
developers for the tools to do that). If they don't do so, then their
users will suffer anyway. So it's not a big deal to ask them to teach
their users to add a "--prng" option to "git bisect start" for example
or something like that to try to work around the "not cleanliness" of
their graphs.

Best regards,
Christian.
