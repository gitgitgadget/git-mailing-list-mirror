From: "Ray Chuan" <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] http-push: remove MOVE step after PUT when sending objects to server
Date: Sun, 18 Jan 2009 03:19:01 +0000
Message-ID: <be6fef0d0901171919ub28dda7ref6443abec3627aa@mail.gmail.com>
References: <be6fef0d0901171224y35c3d95cn2d38639ac03c3b8f@mail.gmail.com>
	 <7viqod5thi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 04:20:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOOD7-0007de-5d
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 04:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757919AbZARDTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 22:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755948AbZARDTF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 22:19:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.179]:21004 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143AbZARDTD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 22:19:03 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1209674wah.21
        for <git@vger.kernel.org>; Sat, 17 Jan 2009 19:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mBp4NJYHDip46sSha8aOKOJn+Uzp9lTGsFUTI0sSRPE=;
        b=FBejTdxDVLM2OZV8XG8lUYlo6BaxTPW9XPlxHdGq6bq/8X5clwy5XKcjyFJNgkcNUV
         h1HdY6Skq0V8j7khZ0PyuI5xYat/F2goNnzbjKTY+06Enmt9cy+va1KxVnClUgxDRHB3
         1FKpGXeBhS78224ccchgyupAaFc11ouZoruKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gFywtf1EIbaUvN17bEPmQs+Y7Da0Q+zhTKr8iX0Of3FM8m51XvdfhVnYthj1FJ9HxX
         Jynp3eQ7NA4J0ACD586DsZflWZ8tQ/4q4IOl2YQ7od+eamhXBsewXEp6OVOIrDC7zOvP
         W+1D4mBs4obk90SGxfFX8S3ss7dWZCP8ASr9c=
Received: by 10.114.171.1 with SMTP id t1mr3019614wae.74.1232248741659;
        Sat, 17 Jan 2009 19:19:01 -0800 (PST)
Received: by 10.114.196.2 with HTTP; Sat, 17 Jan 2009 19:19:01 -0800 (PST)
In-Reply-To: <7viqod5thi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106136>

Hi,

On Sun, Jan 18, 2009 at 12:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ray Chuan" <rctay89@gmail.com> writes:
>
>> Currently, git PUTs to
>>
>>  /repo.git/objects/1a/1a2b...9z_opaquelocktoken:1234-....
>>
>> then MOVEs to
>>
>>  /repo.git/objects/1a/1a2b...9z
>>
>> This is needless. In fact, the only time MOVE requests are sent is for
>> this sole purpose (ie. of renaming an object).

this would be my "true" reason. i do believe PUTting to a "temporary"
file (ie with '__opaquelocktoken:1234-....' appended) to be a needless
step.

>> A concern raised was repository corruption in the event of failure
>> during PUT. "put && move" won't afford any more protection than using
>> simply "put", since info/refs is not updated if a PUT fails, so there
>> is no cause for concern.
>
> That's a completely bogus reasoning.  Normal operation inside the
> repository that was pushed into won't look at info/refs at all.
>
> The true reason you want to avoid put-then-move is...?

i mentioned this "repository corruption" issue as it was raised
previously by Johannes (towards the bottom):

  http://article.gmane.org/gmane.comp.version-control.git/106031

-- 
Cheers,
Ray Chuan
