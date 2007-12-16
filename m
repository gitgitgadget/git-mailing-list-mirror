From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 11:26:37 -0500
Message-ID: <20071216162637.GA3934@fieldses.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <1197776919-16121-1-git-send-email-bfields@citi.umich.edu> <1197776919-16121-2-git-send-email-bfields@citi.umich.edu> <1197776919-16121-3-git-send-email-bfields@citi.umich.edu> <1197776919-16121-4-git-send-email-bfields@citi.umich.edu> <1197776919-16121-5-git-send-email-bfields@citi.umich.edu> <fk2pua$b4p$1@ger.gmane.org> <25FDB05F-3E85-4E08-90BE-1BE468C07805@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 17:27:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3wKV-0004k1-Cz
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 17:27:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763750AbXLPQ0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Dec 2007 11:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754086AbXLPQ0l
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 11:26:41 -0500
Received: from mail.fieldses.org ([66.93.2.214]:43701 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754007AbXLPQ0k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 11:26:40 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3wK5-0001Jw-Mo; Sun, 16 Dec 2007 11:26:37 -0500
Content-Disposition: inline
In-Reply-To: <25FDB05F-3E85-4E08-90BE-1BE468C07805@wincent.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68463>

On Sun, Dec 16, 2007 at 11:00:55AM +0100, Wincent Colaiuta wrote:
> El 16/12/2007, a las 10:08, Jakub Narebski escribi=C3=B3:
>
>> J. Bruce Fields wrote:
>>
>>> This allows catching initial indents like '\t        ' (a tab follo=
wed
>>> by 8 spaces), while previously indent-with-non-tab caught only inde=
nts
>>> that consisted entirely of spaces.
>>
>> I prefer to use tabs for indent, but _spaces_ for align. While previ=
ous,
>> less strict version of check catches indent using spaces, this one a=
lso
>> catches _align_ using spaces.

No, the previous version didn't work for the align-with-spaces case
either.  Consider, for example,

struct widget *find_widget_by_color(struct color *color,
                                    int nth_match, unsigned long flags)

If following a "indent-with-tabs, align-with-spaces" policy, then the
initial whitespaace on the second line should be purely spaces
(otherwise adjusting the tab stops would ruin the alignment).  But
indent-with-non-tab would flag this as incorrect even before my fix.

> I'd say that Jakub's is a fairly common use case (it's used in many p=
laces=20
> in the Git codebase too, I think) so it would be a bad thing to chang=
e the=20
> behaviour of "indent-with-non-tab".
>
> If you also want to check for "align-with-non-tab" then it really sho=
uld be=20
> a separate, optional class of whitespace error.

I would agree with you if it were not for the fact that if you're using
an "indent-with-tabs, align-with-spaces" policy then the only indent
whitespace problems that you can flag automatically are space-before-ta=
b
problems; anything else requires knowledge of the language syntax.

So indent-with-non-tab has only ever been useful for projects that
insist on tabs for all sequences of 8 spaces in the initial whitespace.

--b.
