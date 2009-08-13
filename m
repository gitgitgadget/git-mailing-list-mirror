From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git gc expanding packed data?
Date: Thu, 13 Aug 2009 18:31:19 +0100
Message-ID: <3ace41890908131031t10e32fa5t6b67643ada6befbe@mail.gmail.com>
References: <3ace41890908041325v24ed9e2eh95ecc148305f7775@mail.gmail.com>
	 <alpine.LFD.2.00.0908042203380.16073@xanadu.home>
	 <3ace41890908110317k6e6ada07jc39ea446f9fa246e@mail.gmail.com>
	 <alpine.LFD.2.00.0908111718490.10633@xanadu.home>
	 <3ace41890908120745y305b2a59hd453b7e146e4a774@mail.gmail.com>
	 <alpine.LFD.2.00.0908121118420.10633@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 19:31:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbe9J-0002Oc-HP
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 19:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbZHMRbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 13:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755229AbZHMRbT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 13:31:19 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:34956 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbZHMRbT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 13:31:19 -0400
Received: by ey-out-2122.google.com with SMTP id 22so185818eye.37
        for <git@vger.kernel.org>; Thu, 13 Aug 2009 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HEa97bAwVce/qXvZ1SGjs6bet21Xxu9eXSSDlQN8IDA=;
        b=wVJle7jAFXSopvWLuHdJdDhU4YOfZnookZcF+oXNSVjoGYyHS1uOpJEgKL62jd3x4I
         ZTMw6uWgrEMDYgl0MQs3v/LlpZkEtzwKf1bNJQijv3gsWqEq80OZ/TmaXjVamBHJ0zDx
         /OuTAg6S3h+ISMoBErP6N1TTUf7dmD/Vc1YCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Wmtf29ZhLqW7vjADDxwlaDGfe216JyzIZDiCVg7PGlCcAHNuQBoodcbLX6I93BENYg
         l9dHPfKsroGlAT2MZZ7tnAMX8ALm9fdPbC4zxWjmz+k2LQrAkZSemlgJxZrLmztRrEgW
         grUJx1o54/yBVKC6k/HgH8zof+bGWKMIUVLh8=
Received: by 10.216.88.65 with SMTP id z43mr239727wee.5.1250184679651; Thu, 13 
	Aug 2009 10:31:19 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908121118420.10633@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125845>

On Wed, Aug 12, 2009 at 4:35 PM, Nicolas Pitre<nico@cam.org> wrote:
> On Wed, 12 Aug 2009, Hin-Tak Leung wrote:
>
>> On Tue, Aug 11, 2009 at 10:33 PM, Nicolas Pitre<nico@cam.org> wrote:
>> <snipped>
>>
>> > From git v1.6.3 the --aggressive switch makes for 'git repack' to be
>> > called with --window=250 --depth=250, meaning the equivalent of:
>> >
>> >        git repack -a -d -f --window=250 --depth=250
>> >
>> > Do you still get a huge pack with the above?
>> >
>> >> I guess --aggressive doesn't always save space...
>> >
>> > If so that is (and was) a bug.
>>
>> I tried 'git repack -a -d -f --window=250 --depth=250' with 1.6.2.5
>> (fc11.x86_64) and it took half a day, swallowed up all the memory -
>> 3GB virtual & 1.3GB resident - and finally the kernel oom killer
>> killed it at a last message of (601460/957910). Left no temp files.
>> Would git 1.6.3 use less memory? :-(
>
> Probably not.  However you should try:
>
>        git config pack.deltaCacheSize 1
>
> That limits the delta cache size to one byte (effectively disabling it)
> instead of the default of 0 which means unlimited.  With that I'm able
> to repack that repository using the above git repack command on an
> x86-64 system with 4GB of RAM and using 4 threads (this is a quad core).
> Resident memory usage grows to nearly 3.3GB though.
>
> If your machine is SMP and you don't have sufficient RAM then you can
> reduce the number of threads to only one:
>
>        git config pack.threads 1
>
> Additionally, you can further limit memory usage with the
> --window-memory argument to 'git repack'.  For example, using
> --window-memory=128M should keep a reasonable upper bound on the delta
> search memory usage although this can result in less optimal delta match
> if the repo contains lots of large files (and I think this is the case
> for the gcc repo).
>
>
> Nicolas
>

Thanks.  I used the two git config pack.* commands, and
   git repack -a -d -f --window=250 --depth=250
finished after 8 hours (dual core Turion, 2GB RAM + 2GB swap). The
pack directory went from 457MB to 308MB.

Thanks a lot for the advice - learned a few interesting things about
git on the way :-).

Hin-Tak
