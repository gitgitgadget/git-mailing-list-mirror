From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: "make quick-install-man" broke recently
Date: Sun, 16 Aug 2009 22:58:43 -0700
Message-ID: <8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com>
References: <86my5z8cjd.fsf@blue.stonehenge.com> <7vy6pj449g.fsf@alter.siamese.dyndns.org> 
	<86iqgn8brv.fsf@blue.stonehenge.com> <7vd46v3tp1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 08:06:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McvMk-00087g-6o
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 08:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786AbZHQGGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 02:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbZHQGGh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 02:06:37 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:2917 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951AbZHQGGg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 02:06:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so2690011and.1
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 23:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=arTnlwi1uSmTlREwUmO23Qpwyupoo6zcIN9NDX1BinQ=;
        b=kP+D/M9WG7/7fiDD+a1w7ZHHaAtJh1GWKhbU2+esV8RcT64t37TqIthANf88UFitG8
         6cVsbRo1tLMvJwldhiR0O2ab4hmF/rSobQtg0uawEmens3ZkXbA7pgETIRzrie0J0c+F
         KkJJtUtwU5HWtpgsVBK31NGtH1xQLgQ43p1Sc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=k/XSbX8/MZHQ1GlS3SstR0l7hq3d7aWH40rb33iJXJ6vR2f0i8ulDXmeyXl908NmIw
         MMi55G/y+cYSuLpmZFg/cooZbuupm/VqJmC+V9BkJfhsdyoA+f53cbkkJNshdToU3Yoa
         o7qbm3kTsPVplM2bb8IKsSEFRjJ/rlVZs7wfI=
Received: by 10.101.10.13 with SMTP id n13mr2991955ani.88.1250488743064; Sun, 
	16 Aug 2009 22:59:03 -0700 (PDT)
In-Reply-To: <7vd46v3tp1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126122>

On Sun, Aug 16, 2009 at 22:17, Junio C Hamano<gitster@pobox.com> wrote:
> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>
>> % rm -rf /opt/git/share/man
>> % make prefix=/opt/git quick-install-man
>> make -C Documentation quick-install-man
>>     SUBDIR ../
>> make[2]: `GIT-VERSION-FILE' is up to date.
>> '/bin/sh' ./install-doc-quick.sh origin/man /opt/git/share/man
>> % make prefix=/opt/git quick-install-man
>> make -C Documentation quick-install-man
>>     SUBDIR ../
>> make[2]: `GIT-VERSION-FILE' is up to date.
>> '/bin/sh' ./install-doc-quick.sh origin/man /opt/git/share/man
>> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-add.1 (File exists)
>> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-am.1 (File exists)
>> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-annotate.1 (File exists)
>> error: git checkout-index: unable to create file /opt/git/share/man/man1/git-apply.1 (File exists)
>> [...]
>>
>> So it fails the second time.  This is new behavior.
>
> Interesting, and this does not reproduce for me.
>
> I've tried "run twice back to back" like you did above, "run once, then
> 'find -type f -print | xargs touch' the target, and then run again", and also
> "run once, then 'find -type f -print | xargs chmod -w' the target, and then run again".
>
> None of these fail.
>
> One way I can think of to break it deliberately would be:
>
>        make prefix=/var/tmp/gomikuzu quick-install-man
>        find /var/tmp/gomikuzu -type d | xargs chmod -w
>        make prefix=/var/tmp/gomikuzu quick-install-man
>
> But then the failure is different from what you showed above:
>
>    error: unable to unlink old '/var/tmp/gomikuzu/share/...' (Permission denied)
>
> Puzzled.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I was able to reproduce this one one of the machines I have access to,
and bisecting shows that it was introduced by b6986d8 (git-checkout: be
careful about untracked symlinks).  This makes sense, since home-dirs
are symlinks on the machine I was able to reproduce it on.

Hopefully this helps someone with a little stronger fu, to point them in
the right direction.

Randal, does your machine have a similar symlinked $HOME setup?
