From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH 0/8 v6] diff --stat: use the full terminal width
Date: Wed, 22 Feb 2012 12:24:52 +0100
Message-ID: <4F44D084.7030308@in.waw.pl>
References: <1329775034-21551-1-git-send-email-zbyszek@in.waw.pl> <7v4nuljcnk.fsf@alter.siamese.dyndns.org> <4F42E4C2.7070801@in.waw.pl> <7vr4xois3l.fsf@alter.siamese.dyndns.org> <4F436C5D.7070606@in.waw.pl> <7v1upogd6w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	pclouds@gmail.com, j.sixt@viscovery.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 12:25:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0AJo-0008KZ-4o
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 12:25:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755794Ab2BVLZA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 06:25:00 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:54998 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755459Ab2BVLY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 06:24:59 -0500
Received: from amanda.fuw.edu.pl ([193.0.82.254] helo=[192.168.121.139])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S0AJe-0007WC-5m; Wed, 22 Feb 2012 12:24:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7v1upogd6w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191248>

On 02/21/2012 09:10 PM, Junio C Hamano wrote:
> Zbigniew J=C4=99drzejewski-Szmek<zbyszek@in.waw.pl>  writes:
>
>> This seem overly complex. A nice property to have would be
>> "if the window is wide enough so there's enough space for full
>> filenames, the graph part scales monotonically with the change count=
".
>> (If there's filename truncation, than there just isn't enough space
>> for everything and the graph may be compressed. But otherwise, if we
>> have two graphs which do not end at the edge of the screen, and the
>> second one is wider than the first one, then without looking at the
>> change counts we know that the second one has more changes).
>>
>> For this property to be satisfied, the graph_width limit would have =
to
>> be independent of the filename width.
>>
>> So maybe it should be ...
>
> Sorry, the desired property I would understand, but that does not cli=
ck
> with your "have to be independent" conclusion, so I do not have comme=
nt on
> the "maybe it should be..." part.
Hi,

by "scales monotonically with the change count" I meant with two=20
different commits. Image that there are two commits
   a | 300 ++++++++++++++++++++++
and
   a/a/a/b | 300 ++++++++++++++++++++++
Both commits have the same change count, but filenames of different=20
length. If the filename length can influence the number of "+" in the=20
graph, then the scaling is not monotonic. There would always be cases=20
when a bigger change with longer filenames has a narrower graph.

> The resolution requirement may want to set a "desired lower limit" fo=
r the
> width of the graph, but it is only "desired" because it is possible t=
hat
> you have to bust the limit if you have three files with 1, 9999 and 1=
0000
> changed lines and your terminal is only 200 columns wide.
>
> The current code caps name part to 50/80, but allows the graph to use=
 more
> when you have only shorter names.  Perhaps you can follow the same lo=
gic
> in the first part of your [7/8] (which needs to be separated to at le=
ast
> in two pieces, as it conflates the "lift 50-column cap from the name =
width
> and make it proportional to the term_width()" part and "but cap the g=
raph
> part to 40-column" part, that are separate topics)?  Then we can try
> different heuristics to find a better way to cap the length of the gr=
aph
> on top?
Sure. I'll be replying to this mail with patches
  [7.1/8] use a maximum of 5/8 for the filename part
  [7.2/8] add a test for output with COLUMNS=3D40
  [7.3/8] limit graph part to 40 columns

--
Zbyszek
