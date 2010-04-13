From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH v2 1/4] output: Add a new library for plumbing output
Date: Tue, 13 Apr 2010 12:46:52 +0100
Message-ID: <30465b96f3938b1a993ead64bcfb03b0@212.159.54.234>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk> <20100411232118.67460.52907.julian@quantumfyre.co.uk> <20100413094351.GA2558@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>, Jakub Narebsk <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Raymond <esr@thyrsus.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Apr 13 13:47:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1ea5-0003bP-S2
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 13:47:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047Ab0DMLq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 07:46:56 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:59945 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750906Ab0DMLqz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Apr 2010 07:46:55 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id A3C5D819C721;
	Tue, 13 Apr 2010 12:46:47 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 7E76720CF83;
	Tue, 13 Apr 2010 12:46:53 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id sNrWglt5Ld5B; Tue, 13 Apr 2010 12:46:53 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id DF27D20CEF2;
	Tue, 13 Apr 2010 12:46:52 +0100 (BST)
In-Reply-To: <20100413094351.GA2558@LK-Perkele-V2.elisa-laajakaista.fi>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144815>

On Tue, 13 Apr 2010 12:43:51 +0300, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Mon, Apr 12, 2010 at 12:21:14AM +0100, Julian Phillips wrote:
> 
> I'm writing S-Expression output backend as experiment (not yet even
> sendable
> as WIP) and hit an issue in general framework...
> 
> Also, some comments on documentation...
> 
>> +The output consists of objects, arrays and the actual values, the term
>> item is
>> +used where any of these may be used, and container when either an
>> object or
>> +array may be used.  Objects are unordered collections of named items,
>> and arrays
>> +are ordered collections of unnamed items.  For simplicity a name is
>> always
>> +supplied when creating an item - though it may not always be used
(e.g.
>> if you
>> +are adding the item to a list).
> 
> List? Above says types are 'object', 'array' and 'value'. Then it
defines
> terms 'item' and 'container'. But what is 'list'?

typo - should be array.

>> +* Unstructured Output Functions
> 
> Maybe add extra note about these. When one sees output_token used in
code
> outputting stuff, one can get puzzled until one realizes that token
output
> is ignored for non normal/zero outputs.

Yes.  I intend to revist the header and documentation, as they were mostly
done before the normal output was added.

>> diff --git a/output.c b/output.c
>> new file mode 100644
>> index 0000000..ac8feb1
>> --- /dev/null
>> +++ b/output.c
> 
>> +void output_end(struct output_context *context)
>> +{
>> +	while(context->current)
>> +		output_end_current(context);
>> +
>> +	/*
>> +	 * OUTPUT_NORMAL and OUTPUT_ZERO are special cases - the output
format
>> +	 * is _already_ defined so we have to stick to the rules, we can't
add
>> +	 * _anything_
>> +	 */
>> +	if (context->style > OUTPUT_ZERO)
>> +		fprintf(context->file, "\n");
> 
> This is AFAIK really inapporiate for canonical S-Expression output.
Point
> of
> canonical S-Expressions is to have only one way to serialize given tree
> (bit
> for bit identicality) and linefeeds are not allowed except as
serialization
> of linefeed in string.
> 
> Perhaps one could add method/flag to output backend to tell wheither to
> print trailing linefeed?

I think that it probably makes sense to have explicit calls into the
backend for start and end rather than assuming that wrapping everything in
an object is appropriate, an XML backend for example could then use those
callbacks to do XML headers and the outmost element tags etc.

-- 
Julian
