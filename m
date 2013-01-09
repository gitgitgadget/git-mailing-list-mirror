From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: On --depth=funny value
Date: Wed, 9 Jan 2013 21:12:01 +0700
Message-ID: <CACsJy8B4SFs5gbrD6vKvpcrv-tyUo+aZAvq=VmVFM1Bsiggu4w@mail.gmail.com>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com>
 <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com>
 <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org> <CACsJy8CA-a0=HqTY9heJBhPO4M5jyLk=tf253rRKCRuTWz5teg@mail.gmail.com>
 <7vr4lv7x2u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 15:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TswOl-0000DY-3a
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 15:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757926Ab3AIOMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 09:12:34 -0500
Received: from mail-oa0-f52.google.com ([209.85.219.52]:62521 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757922Ab3AIOMd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 09:12:33 -0500
Received: by mail-oa0-f52.google.com with SMTP id o6so1001809oag.39
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Ep6qdol0hdwIWrT7VkG5xjcHpKjSsx5YAjhIz6/mWrg=;
        b=SeMgJw1YuG/OuyQ/YUmObSuGF9kVN9wBXGSKH5PGWl2102KXF/zcxSJfmQQ4u8aJRw
         bEzWADEe4ezjonVLhdvc2Kz4lrIPoenpEx27U8LGXJyENtOE0hpniN44pjSHAOWoMibn
         ABWsARZyv+craav8OpeLm/f+M5ONp11Dgd/gvdfa4dmU9VHrvlzaTNF4FncsnHl7VoKc
         KlFMRpdJnBVbH2plWdTCfNExE05F9LyjGNTkHbhfQmrZm60jS9+t8O+Le8T+I9Id1JNe
         oBmobQ+88tQtFxj4VgMmFlUzwpHWDh3t8bvKW3p3sH+3APFyBiGKzN4XvrMkVqyQIJ58
         7EYA==
Received: by 10.182.159.5 with SMTP id wy5mr47802530obb.31.1357740751855; Wed,
 09 Jan 2013 06:12:31 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Wed, 9 Jan 2013 06:12:01 -0800 (PST)
In-Reply-To: <7vr4lv7x2u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213058>

On Wed, Jan 9, 2013 at 12:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jan 9, 2013 at 9:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>>  * We would like to update "clone --depth=1" to end up with a tip
>>>    only repository, but let's not to touch "git fetch" (and "git
>>>    clone") and make them send 0 over the wire when the command line
>>>    tells them to use "--depth=1" (i.e. let's not do the "off-by-one"
>>>    thing).
>>
>> You can't anyway. Depth 0 on the wire is considered invalid by upload-pack.
>
> Yes, that is a good point that we say "if (0 < opt->depth) do the
> shallow thing" everywhere, so 0 is spcial in that sense.
>
> Which suggests that if we wanted to, we could update the fetch side
> to do the off-by-one thing against the current upload-pack when the
> given depth is two or more, and still send 1 when depth=1.  When
> talking with an updated upload-pack that advertises exact-shallow
> protocol extension, it can disable that off-by-one for all values of
> depth.  That way, the updated client gets history of wrong depth
> only for --depth=1 when talking with the current upload-pack; all
> other cases, it will get history of correct depth.
>
> Hmm?

I haven't checked because frankly I have never run JGit, but are we
sure this off-by-one thing applies to JGit server as well? So far I'm
only aware of three sever implementations: C Git, JGit and Dulwich.
The last one does not support shallow extension so it's out of
question.
-- 
Duy
