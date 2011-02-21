From: Guy Rouillier <guyr@burntmail.com>
Subject: Re: cvsimport still not working with cvsnt
Date: Sun, 20 Feb 2011 23:30:03 -0500
Message-ID: <4D61EA4B.3020708@burntmail.com>
References: <4D0ED5EC.9020402@burntmail.com> <20101220213654.GA24628@burratino> <4D112586.2060904@Freescale.com> <4D119015.6020207@burntmail.com> <4D2AB63D.7040803@burntmail.com> <AANLkTikreDJmUPfwNJ2ABivrafjvQNN6WrytNMAcse4A@mail.gmail.com> <4D2FEF49.8070205@burntmail.com> <20110114074449.GA11175@burratino> <7v8vynnokt.fsf@alter.siamese.dyndns.org> <4D450655.5090501@burntmail.com> <AANLkTik0Mp=Ww_+ZN_jw6t4gsFwLo1UTw5JOpho8bCd=@mail.gmail.com> <7vhbcb35xk.fsf@alter.siamese.dyndns.org> <4D5E1116.7040501@burntmail.com> <7voc69p4xu.fsf@alter.siamese.dyndns.org> <4D5F6E97.4000402@burntmail.com> <7vy65bkw72.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin@laptop.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Emil Medve <Emilian.Medve@freescale.com>,
	git <git@vger.kernel.org>, Pascal Obry <pascal@obry.net>,
	Clemens Buchacher <drizzd@aon.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 05:31:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrNQU-0007gl-BP
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 05:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755799Ab1BUEbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 23:31:05 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:41050 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755541Ab1BUEbD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 23:31:03 -0500
Received: from [173.79.61.50] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.72)
	(envelope-from <guyr@burntmail.com>)
	id 1PrNPR-0004XH-JA; Sun, 20 Feb 2011 22:30:05 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vy65bkw72.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167440>

On 2/20/2011 2:21 AM, Junio C Hamano wrote:
> Guy Rouillier <guyr@burntmail.com> writes:
> 
>> The two clients use a different delimiter to separate the CVS
>> repository name from the user password.  The original CVS
>> client separates the two entries with a space character, while
>> CVSNT separates them with an equal (=) character.  Hence,
>> the regular expression used to split these two tokens is
>> altered to accept either delimiter.
> 
> That sounds like a wrong approach.  If there are two clients, one reads
> from one location with one syntax, and the other one reads from another
> different location with a different syntax, shouldn't the code using the
> original syntax when reading the original file, and the other syntax when
> reading the file for the other client?

...

> In practice, I would imagine that the cvsroot part wouldn't contain an
> equal sign, so this looser regexp would not hurt in the real life, but it
> does feel yucky.

Well, this is the important point. I did think of these aspects when
writing the code.  Sure, writing more precise code is possible, but the
results are the same in either case.  If you look back at the version I
wrote in response to Emil's post, I did have two entirely separate 
sections for CVS and CVSNT, and I used only one delimiter in each.  
Martin then suggested I combine the two sections into one, so while
following that suggestion I had to alter the regular expression.

> Here is a totally untested patch.  I think the original code used
> $pass="A" as a fall-back when it didn't find any password entry, and I
> tried to retain that instead of dying.  Also this does not error out if
> you merely have two cvspass files, as long as you do not have the wanted
> entry for both of them.

I'll take a look at the patch later this week when I have some time.  I
purposely took out the code the set the password to "A" if the CVS
repository is not located in the password file.  I was surprised to
see that in the original code.  I can't think of any situation 
where silently making up a password is a good idea.

Finally, after our last round of discussions, I thought we all agreed
not to try to do any matching on the contents of the two password files.
I originally implemented a comparison of the contents of the two files,
but you pointed out there are many possible permutations involving
entries found in both files.  So I went back to my earlier approach
of just erroring out if both files are found.

-- 
Guy Rouillier
