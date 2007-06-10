From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/21] Introduce optional "keywords" on tag objects
Date: Sat, 09 Jun 2007 17:05:29 -0700
Message-ID: <7vfy50d67q.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
	<7vzm3aig7j.fsf@assigned-by-dhcp.cox.net>
	<200706090210.36270.johan@herland.net>
	<200706090219.37289.johan@herland.net>
	<81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johan Herland" <johan@herland.net>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 02:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxAw2-0002xx-Uf
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 02:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543AbXFJAFb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 20:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758572AbXFJAFb
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 20:05:31 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:40650 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757631AbXFJAFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 20:05:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610000529.ECEB25947.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 9 Jun 2007 20:05:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9c5U1X00A1kojtg0000000; Sat, 09 Jun 2007 20:05:29 -0400
In-Reply-To: <81b0412b0706091452q2957540dy95fbf13ebd89ca1f@mail.gmail.com>
	(Alex Riesen's message of "Sat, 9 Jun 2007 23:52:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49642>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 6/9/07, Johan Herland <johan@herland.net> wrote:
>> This patch introduces a new optional header line to the tag object, called
>> "keywords". The "keywords" line may contain a comma-separated list of
>> custom keywords associated with the tag object.
>
> What is the character set for the keywords?
>
>> +                       for (i = 0; i < keywords_len; ++i) {
>> +                               unsigned char c = keywords_line[i];
>> +                               if (c == ',' && keywords_line[i + 1] == ',')
>> +                                       /* consecutive commas */
>> +                                       return error("Tag object (@ char "
>> +                                               PD_FMT "): Found empty keyword",
>> +                                               keywords_line + i - data);
>> +                               if (c > ' ' && c != 0x7f)
>> +                                       continue;
>
> And what is so special about 0x7f?

It is DEL, but as the code uses uchar, it probably also error on
0x80 or higher, if the intent is "printable ASCII".
