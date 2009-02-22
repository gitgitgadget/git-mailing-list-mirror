From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Blamming a diff between two commits?
Date: Sun, 22 Feb 2009 19:49:16 +0100
Message-ID: <vpqtz6mpas3.fsf@bauges.imag.fr>
References: <499AB8A1.7090909@datacom.ind.br>
	<20090222123248.GA6504@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbJU4-0001uz-Cs
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbZBVSwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbZBVSwt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:52:49 -0500
Received: from imag.imag.fr ([129.88.30.1]:39054 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751710AbZBVSwt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:52:49 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n1MInGJq016625
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 22 Feb 2009 19:49:16 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1LbJO8-0002FX-B4; Sun, 22 Feb 2009 19:49:16 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1LbJO8-0007Q2-7I; Sun, 22 Feb 2009 19:49:16 +0100
In-Reply-To: <20090222123248.GA6504@efreet.light.src> (Jan Hudec's message of "Sun\, 22 Feb 2009 13\:32\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.60 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 22 Feb 2009 19:49:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111048>

Jan Hudec <bulb@ucw.cz> writes:

> On Tue, Feb 17, 2009 at 10:16:17 -0300, Samuel Lucas Vaz de Mello wrote:
>> Hi,
>> 
>> Is there any way to git blame (or annotate) a diff between two commits?
>> 
>> I'm looking for something that produce something like this:
>> 
>>                               /**
>> 85a02065 (samuel 2009-01-02) - * \brief      Define a participacao da porta estatica/dinamica
>> 85a02065 (samuel 2009-01-02) - * \param      unit            indice da unidade
>> e106303a (arthur 2009-01-17) - * \param	     extraparam      extra parameter
>> 85a02065 (samuel 2009-01-02) - * \param      port            indice da porta
>> 50e22e7d (fabian 2009-01-09) - * \param      deleted         param to be deleted
>> 85a02065 (samuel 2009-01-02) + * \brief      Sets port membership on a static / dynamic 
>> 85a02065 (samuel 2009-01-02) + * \param      unit            unit index
>> 85a02065 (samuel 2009-01-02) + * \param      port            port index
>> e106303a (arthur 2009-01-17) + * \param	     another         another index
>>                                * \return     0 if Ok; -1 in error
>>                                */
>> 
>> This would be useful for code reviews. I can use a diff containing all changes committed to a branch, for example, in the last 10 days to review. Doing this instead of reviewing individual commit patches save us from waste time analyzing code that has already been changed/fixed. 
>> 
>> Using a git-blame in the resulting file give me the commits for the lines added, but not for the deleted ones.
>> 
>> Any suggestion on how to do this?
>
> What about doing a diff of the blames? It should do the same thing (except
> the +/- would be at the begining of the lines). Well, not exactly, because if
> there was a change, that was reverted again, blames would change, so it would
> appear here, but that's probably rare enough to ignore (if you don't even
> want to see it rather than not).

I don't think that would do it.

Suppose I have the following history (in a one-line file) :

revision: R1 -> R2 -> R3 -> R4 -> R5 -> R6
content:  A  -> B  -> B  -> C  -> D  -> E 

If I do a blame at revision R3, I'll get

R2 B

Then, at revision R6, I'd get

R6 E

so the diff will be

- R2 B
+ R6 E

while the original poster actually wanted

- R3 B
+ R6 E

In the first case, the annotation for - lines tell where the removed
line had been introduced before, while the second case tells up to
which revision the line has been existing (or, it could show the
revision which removed it, R4 here).


-- 
Matthieu
