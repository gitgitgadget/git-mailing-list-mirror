From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [RFD] Notes are independent: proposal for new notes 
	implementation
Date: Tue, 9 Feb 2010 16:37:43 -0500
Message-ID: <32541b131002091337t3848a87fg2d35ec4c198465b1@mail.gmail.com>
References: <201002092105.25636.jnareb@gmail.com> <32541b131002091226p58b40237j40d3cd6cfaa91df5@mail.gmail.com> 
	<201002092155.29304.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jon Seymour <jon.seymour@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:38:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nexmf-0002hh-2v
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 22:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344Ab0BIViI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2010 16:38:08 -0500
Received: from mail-iw0-f183.google.com ([209.85.223.183]:52512 "EHLO
	mail-iw0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0BIViG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Feb 2010 16:38:06 -0500
Received: by iwn13 with SMTP id 13so8881124iwn.25
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 13:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=f1/B5MQAovNVJ5Uq4JLxOMbtNozFuPWoVqjUT1MlBVk=;
        b=tVCMN6crA2cdWTX2XecbTMxAfUftZnhJf1Df+7jN42G1LqS2/Br9YQhMld6H1XMo+U
         nbcfBeEJhpLj4ZCxJWTtRqYEYfKnwOItY1sPFxkarulH30OquP7TcGBbrT6KSTEKn95g
         iPRjHZpqvBMJnwr7pvX+LJcr4Zy/+SBg/92aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RsVP5EuVro4zlaB3o3QQ5jhFWxqHmusAiatrSnOjYS+mPuBlh7/zB75orLlhmuX/Dq
         kYx9LL60JxJNQBXLDw2yN/yyXq0ZzCVzVYD267iE+3vg1UyBDzfgQ2kUEfzmox6KMJFk
         MaShT44aVW37ldwm8d3uhAzBrC+OyWnijhe2A=
Received: by 10.231.173.129 with SMTP id p1mr676390ibz.85.1265751483105; Tue, 
	09 Feb 2010 13:38:03 -0800 (PST)
In-Reply-To: <201002092155.29304.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139444>

On Tue, Feb 9, 2010 at 3:55 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Tue, 9 Feb 2010, Avery Pennarun wrote:
>> 2010/2/9 Jakub Narebski <jnareb@gmail.com>:
>> > But
>> > what if the answer was to change implementation, decoupling histor=
y of
>> > notes from each other, and keeping history of each note separate.
>>
>> Congratulations, you've re-invented CVS! :)
>>
>> Seriously though, I'm not sure what problems this solved. =A0Notes t=
hat
>> are related to each other can (and perhaps should) be in the same
>> notes commit history; notes that are not related to each other can
>> exist in separate histories with their own ref.
>
> The problem is (as I see it) that notes are _not_ (in almost all case=
s)
> related to each other, just like files in $HOME or in /etc are not
> related to each other.

As a side note, I didn't find this example compelling at all.  I
*absolutely* want to manage all my files in /etc as a single repo.
"The configuration of my computer" is an ongoing project where the
configuration of my smtp daemon depends on /etc/hosts and /etc/passwd
and /etc/group.  If I set up another server, I want to be able to fork
my basic configuration and apply some patches.  If I set up some
clever aliases in /etc/profile, I want to send that patch "upstream"
to the /etc project on my other servers.

Similarly with $HOME; the evolution of my home directory over time is
a thing I can talk about as a sensible whole, and of course I want
rename tracking and deltas and so on.

Combining /etc and $HOME into a single repo would be harder to
justify.  But that sounds to me like the "kind (flavor)" distinction
you're talking about; system config files and personal files are two
different kinds of files.

>> > This means for example that if in repository A somebody annotated
>> > commits foo and bar creating notes in this order, and in repositor=
y B
>> > somebody annotated bar and foo (creating notes in reverse order), =
then
>> > merging those changes would require generating merge commit even i=
f
>> > those notes are identical.
>>
>> That's a feature; now you have the true history of your notes, which
>> is good for all the same reasons it's good in git.
>
> No, you are introducing artificial ordering in something that is a ba=
g,
> unordered collection.

I would put it another way: you're recording the true ordering of
something where the ordering *may* not be important.  It is easy to
ignore that ordering.

However, it's very hard to unignore ordering that you didn't record in
the first place.  That's why CVS's model of recording
one-history-per-file is so nasty.  Yet it seemed so clever when they
invented it.

What is a real use case where the "artificial ordering" causes a proble=
m?

Here's a use case where having a single history would be a clear
benefit: say you're running an autobuilder such as gitbuilder[1].
Something goes wrong with your autobuild environment, like the disk
fills up, and all the build results since yesterday at noon are
invalid.  If the build results are stored as a single history of git
notes[2], I can just rewind the history to yesterday at noon and
discard the entire sequence of bad results across all commits.  If
they each had their own history, it would be more complex to
implement.

Have fun,

Avery

[1] http://github.com/apenwarr/gitbuilder

[2] gitbuilder doesn't currently use git-notes, it just uses plain file=
s.
