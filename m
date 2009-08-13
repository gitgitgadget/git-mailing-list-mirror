From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] fast-import: define a new option command
Date: Thu, 13 Aug 2009 12:26:06 -0700
Message-ID: <7vzla3bjn5.fsf@alter.siamese.dyndns.org>
References: <1250140186-12363-2-git-send-email-srabbelier@gmail.com>
 <1250140186-12363-3-git-send-email-srabbelier@gmail.com>
 <20090813144327.GK1033@spearce.org>
 <alpine.DEB.1.00.0908131652190.7429@intel-tinevez-2-302>
 <20090813150446.GM1033@spearce.org>
 <fabb9a1e0908130812s297ccfc6vd6b746daf1dcc69a@mail.gmail.com>
 <20090813152419.GN1033@spearce.org>
 <fabb9a1e0908130926qdc6cdf1ka7f2442421ce12ce@mail.gmail.com>
 <alpine.DEB.1.00.0908131907080.7429@intel-tinevez-2-302>
 <fabb9a1e0908131009j51c54cacp3f837f9b8525061@mail.gmail.com>
 <20090813172508.GO1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 21:26:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbfwP-0000Mw-Sa
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 21:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbZHMT0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 15:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754646AbZHMT0Q
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 15:26:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125AbZHMT0P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 15:26:15 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F13C9936;
	Thu, 13 Aug 2009 15:26:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61F799932; Thu, 13 Aug
 2009 15:26:08 -0400 (EDT)
In-Reply-To: <20090813172508.GO1033@spearce.org> (Shawn O. Pearce's message
 of "Thu\, 13 Aug 2009 10\:25\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2A6CC54C-883F-11DE-A5F7-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125855>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sverre Rabbelier <srabbelier@gmail.com> wrote:
>> On Thu, Aug 13, 2009 at 10:07, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> > ... and will import the marks twice?
>> 
>> Ah, you're right :(. What's the best way to do this? Should we dump
>> any previous marks when importing new ones?
>
> Uh, well, yes.  We shouldn't define :5 if it was in the file that
> appeared in the stream, but isn't in the file on the command line.
>
> Worse, what happens if we do this:
>
>   echo "option import-marks=/not/found" \
>   | git fast-import --import-marks=my.marks
>
> I want this to work, even though /not/found does not exist, but
> my.marks does.  So that does complicate things...

How about making the option parser get and keep the _name_ of the file
until option parsing session (i.e. read the stream until initial run of
"option" command runs out and then parse the command line to override),
and then finally open the file and read it?
