From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Sun, 09 Sep 2007 03:36:25 +0200
Message-ID: <46E34E19.8050402@op5.se>
References: <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz> <851wda7ufz.fsf@lola.goethe.zz> <fbr4oi$5ko$1@sea.gmane.org> <85wsv26cv8.fsf@lola.goethe.zz> <fbsbul$dg0$1@sea.gmane.org> <46E3354A.7030407@op5.se> <20070909003718.GE13385@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pierre Habouzit <madcoder@debian.org>,
	Andreas Ericsson <ae@op5.se>,
	Walter Bright <boost@digitalmars.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 03:39:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUBlm-0000vK-6a
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 03:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbXIIBgb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 8 Sep 2007 21:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752358AbXIIBgb
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 21:36:31 -0400
Received: from mail.op5.se ([193.201.96.20]:45290 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbXIIBga (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 21:36:30 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7E7D3194414;
	Sun,  9 Sep 2007 03:36:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fVx5uFpRAAOs; Sun,  9 Sep 2007 03:36:27 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 442B91943B6;
	Sun,  9 Sep 2007 03:36:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070909003718.GE13385@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58142>

Pierre Habouzit wrote:
> On Sat, Sep 08, 2007 at 11:50:34PM +0000, Andreas Ericsson wrote:
>=20
>>>> You can tell C compilers to
>>>> check all array accesses, but that is a performance issue.
>>> Runtime checking of arrays in D is a performance issue too, so it i=
s=20
>>> selectable via a command line switch.
>> Same as in C then.
>=20
>   HAHAHAHAHAHA. Please, who do you try to convince here ? Except in t=
he
> local scope, there is few differences between a foo* and a foo[] in C=
=2E
>=20

"Runtime checking of arrays is a performance issue." It's true whether =
it's
done manually by the coder or by the compiler. The difference is that i=
n C,
you get to choose where it should be done.


>>> But more importantly,
>>> 2) For dynamically sized arrays, the dimension of the array is carr=
ied
>>> with the array, so loops automatically loop the correct number of t=
imes.
>>> No runtime check is necessary, and it's easier for the code reviewe=
r to
>>> visually check the code for correctness.
>> But this introduces handy but, strictly speaking, unnecessary overhe=
ad
>> as well, meaning, in short; 'D is slower than C, but easier to write
>> code in'.
>=20
>   That's BS. See the strbuf API I've been pushing recently ? It has
> simplified git's code a lot, because each time git had to deal with a
> growing string, it had to deal with at least three variables: the buf=
fer
> pointer, the current occupied length, and its allocated size. That wa=
s
> three thing to have variable names for, and to pass to functions.
>=20

Yup. I applaud your efforts, but it does come with a slight overhead,
except where it replaces faulty code. In practice, it's probably better
to use the api for all the string-handling, as none of it is performanc=
e-
critical.


>   Now instead, it's just one struct. D gives that gratis. There is no
> performance loss because you _need_ to do the same. How do you deal w=
ith
> dynamic arrays if you dont't store their lenght and size somewhere ? =
Or
> are you the kind of programmer that write:
>=20
>   /* 640kb should be enough for everyone=E2=80=A6 */
>   some_type *array =3D malloc(640 << 10);
>=20

No, but it would depend on what I am to do with it.

>=20
>> So in essence, it's a bit like Python, but a teensy bit faster and a
>> lot easier to shoot yourself in the foot with.
>=20
>> What was the niche you were going for when you thought up D? It can'=
t
>> have been systems programming, because *any* extra baggage is baggag=
e
>> one would like to get rid of. If it was application programming I fa=
il
>> to see how one more language would help, as there will be portabilit=
y
>> problems galore and it's still considerably slower to develop in tha=
n
>> fe Python, while at the same time being considerably easier to mess =
up
>> in.
>=20
>   Right now I'm just laughing. There is for sure overheads in some
> places of D, but the example you take, and what you try to attack in =
D
> is definitely not where you lose any kind of performance. You could h=
ave
> attacked the GC instead (which is after all an easy classical target)=
=2E
>=20

I was asking what role D was designed to fill. I didn't mean it as an
attack, but re-reading what I wrote earlier I see it came off a bit har=
sh.


>   Just to evaluate the silliness of your arguments:
>   * http://www.digitalmars.com/d/comparison.html so that you can tell
>     what the D features really are,

You may notice that the feature-list is being provided by the creators
and marketeers of the D language. Walter Bright certainly seems like a
nice enough person, but it's possible it's a tad biased.


>   * http://shootout.alioth.debian.org/gp4/benchmark.php?test=3Dall&la=
ng=3Dall
>     so that you can know what the D performance really is about. Of
>     course those are only micro benchmarks, but well, python is "just=
"
>     15 times slower than D, and D seems to be 10% slower.


I get it to 7.7xC and 1.2xC, respectively, but whatever. It still means
performance-critical apps will be written in C, while
insert-script-language-of-choice will still be used for prototyping and
not-so performance-critical apps.


> Well then I'm
>     okay with D, I'm ready to buy 10% faster CPUs and avoid a lot of
>     painful debugging time. In my world, 10% faster hardware is cheap=
er
>     by many orders of magnitude than skilled programmers, but YMMV.
>=20

I'm curious as to how many fewer bugs D developers write compared to C
programmers. I guess it's hard to do a fair test given the comparativel=
y
shallow pool of D gurus around, but it'd still be interesting to see a
practical test. 20% increase in runtime is certainly acceptable for
never having to see a bug again, but is it acceptable for 10% fewer bug=
s?
Or 20% fewer?

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
