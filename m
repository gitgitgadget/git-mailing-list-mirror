From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH/RFC 10/11] gitweb.js: Add UI for selecting common timezone to display dates
Date: Sun, 10 Apr 2011 00:49:25 +0200
Message-ID: <1302389366-21515-11-git-send-email-jnareb@gmail.com>
References: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Kevin Cernekee <cernekee@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 00:50:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8gz9-0005HA-DZ
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 00:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab1DIWuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 18:50:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40519 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755796Ab1DIWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 18:50:05 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so2942648fxm.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 15:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=7BpPVITxnpysjz7nqwH7kCDFZ/iDu+nJLLqc69SQRBk=;
        b=XmwLqMNLSt8dNf2cZbWoAu3TSmWHC1cnFLmKKVaNcXtzoD7D13hVuSalFSx/SQ9Ksf
         m7XvHIzgBuG08MomjIml6xNG4XwMtfrSFYxRdOMcyVJsDdQ1YEUPpPT3utxigciRfJ18
         0Tw2kxUVZ1RjfXa2z//aej4tHC1wm6IuR8X24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NNyV+Q+YtX1s7sWulfcD0kK1ZENJNpcDHBs7Q+MK61504OtZOdWXfbB6rjwyum2rIt
         akXOtqQQfQdJlzJoPlZN5DYE65UXL7FsWnH9s25J09B1xD0qb5/FPFRrG5SJv+anFc2/
         FDuwxcry2WNsu0Xj7S55jIIypP9dt8PJlINx0=
Received: by 10.223.143.12 with SMTP id s12mr1556604fau.121.1302389404170;
        Sat, 09 Apr 2011 15:50:04 -0700 (PDT)
Received: from localhost.localdomain (abwd67.neoplus.adsl.tpnet.pl [83.8.227.67])
        by mx.google.com with ESMTPS id j12sm1188601fax.33.2011.04.09.15.50.02
        (version=SSLv3 cipher=OTHER);
        Sat, 09 Apr 2011 15:50:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1302389366-21515-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171221>

From: John 'Warthog9' Hawley <warthog9@eaglescrag.net>

This will modify HTML, add CSS rules and add DOM event handlers so
that clicking on any date (the common part, not the localtime part)
will display a drop down menu to choose the timezone to change to.

Currently menu displays only the following timezones:

  utc
  local
  -1200
  -1100
  ...
  +1100
  +1200
  +1300
  +1400

In timezone selection menu each timezone is +1hr to the previous.  The
code is capable of handling fractional timezones, but those have not
been added to the menu.

All changes are saved to a cookie, so page changes and closing /
reopening browser retains the last known timezone setting used.

[jn: Changed from innerHTML to DOM, moved to event delegation for
onclick to trigger menu, added close button and cookie refreshing]

KNOWN BUGS:
===========
* In 'log' view menu is generated on the right side of whole page,
  instead of at near date, as is the case with 'summary', 'commit',
  'commitdiff', and 'tag' views.

* Replacing inline style for 'popup' and 'close-button' elements of
  timezone menu with style defined in gitweb.css results in menu being
  put between datetime and its local part, as if absolute positioning
  didn't remove element from the flow.

  Currently style is duplicated in gitweb.css (in CSS file) and in
  <element>.style.cssText (in JavaScript).

* 'close-button' is not placed correctly if it uses 'float: right;'
  style (problem floating element in absolutely positioned box, even
  though there is no problem if containing box is has position: fixed).

  Therefore it was necessary to use absolute positioning for close
  button.  This might cause for it to overlay 'Select timezone:' text
  in some cases.

KNOWN ISSUES:
=============
* It is not easy to discover how to change timezone of dates in gitweb
  output... though the same can be said for other parts of gitweb output.
  Also marking of dates might be a bit misleading.

* Markup should probably change when timezone selection menu is displayed.
  Timezone UI could also be improved.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Changes from J.H. patch:
~~~~~~~~~~~~~~~~~~~~~~~~
* In J.H. patch to display timezone menu you had to click small "+"
  beside date, that was added for each date using JavaScript.

  In this patch to display timezone menu you have to click anywhere
  on date, as hinted by title='Click to change timezone' added to
  those elements via JavaScript, and link-like view on :hover
  via CSS added with JavaScript.

* In J.H. patch clicking on "+" was handled with setting onclick for
  each such element:

    <span onclick="clickDate(event.target);" title="+">+</span>

  once for each date (but only for 'log' view there are many dates).

  In this patch clicking on dates is handled via event delegation
  (event capturing for 'document').

* In J.H. patch timezone menu was generated from scratch on each
  click on unopened "+" (which changed to "-" and handled closing)
  by setting target.innerHTML to string generated by concatenation.

  In this patch timezone menu is generated once on page load, and
  only attached on clicking on date.  This menu is generated using
  DOM methods rather than innerHTML -- this is because my ancient
  browser (Mozilla 1.17.12 Gecko/20050923) considers innerHTML
  non-standard with strict mode (XHTML + application/xhtml+xml).

* In J.H. patch to remove timezone menu without selection you had to
  click on "-" (turning it again into "+").

  In this patch to remove timezone menu you had to click '[x]' button
  marked with title='(click on this box to close)'.

* In J.H. patch timezone menu was composed of table.  In this patch it
  is simply <div> element.

* In J.H. patch to get date gitweb JavaScript parsed title attribute.
  In this patch to get date gitweb JavaScript parses contents of element.

On one hand side with current code is hopefully easier to understand
code flow.  On the other hand it uses much more advanced features of
JavaScript: DOM (mainly DOM HTML, with bits of CSS, Style and Core),
event delegation, closures, absolute positioning / visual model.

 gitweb/static/gitweb.css            |   25 ++++
 gitweb/static/js/adjust-timezone.js |  242 +++++++++++++++++++++++++++++++++--
 gitweb/static/js/lib/common-lib.js  |   27 ++++-
 3 files changed, 283 insertions(+), 11 deletions(-)

diff --git a/gitweb/static/gitweb.css b/gitweb/static/gitweb.css
index 79d7eeb..6d17e12 100644
--- a/gitweb/static/gitweb.css
+++ b/gitweb/static/gitweb.css
@@ -579,6 +579,31 @@ div.remote {
 	display: inline-block;
 }
 
+/* JavaScript-base timezone manipulation */
+
+.popup { // timezone selection UI
+	position: absolute;
+	top: 0; right: 0;
+	border: 1px solid;
+	background-color: #f0f0f0;
+}
+
+.close-button { // close timezone selection UI without selecting
+	//float: right; // float doesn't work within absolutely positioned container
+	position: absolute;
+	top: 0px; right: 0px;
+	border:  1px solid green;
+	margin:  1px 1px 1px 1px;
+	padding: 1px 1px 1px 1px;
+	width:     10px;
+	height:    10px;
+	font-size:  8px;
+	font-weight: bold;
+	text-align: center;
+	background-color: #fff0f0;
+}
+
+
 /* Style definition generated by highlight 2.4.5, http://www.andre-simon.de/ */
 
 /* Highlighting theme definition: */
diff --git a/gitweb/static/js/adjust-timezone.js b/gitweb/static/js/adjust-timezone.js
index 5cebc08..6ac32ca 100644
--- a/gitweb/static/js/adjust-timezone.js
+++ b/gitweb/static/js/adjust-timezone.js
@@ -7,7 +7,8 @@
  */
 
 /**
- * Get common timezone and adjust dates to use this common timezone.
+ * Get common timezone, add UI for changing timezones, and adjust
+ * dates to use requested common timezone.
  *
  * This function is called during onload event (added to window.onload).
  *
@@ -17,13 +18,20 @@
  */
 function onloadTZSetup(tzDefault, tzCookieName, tzClassName) {
 	var tzCookie = getCookie(tzCookieName);
-	var tz = tzCookie ? tzCookie : tzDefault;
+	var tz = tzDefault;
 
-	// server-side of gitweb produces datetime in UTC,
-	// so if tz is 'utc' there is no need for changes
-	if (tz !== 'utc') {
-		fixDatetimeTZ(tz, tzClassName);
+	if (tzCookie) {
+		// set timezone to value saved in a cookie
+		tz = tzCookie;
+		// refresh cookie, so it expires 7 days from last use of gitweb
+		setCookie(tzCookieName, tzCookie, { expires: 7, path: '/' });
 	}
+
+	// add UI for changing timezone
+	addChangeTZ(tz, tzCookieName, tzClassName);
+
+	// adjust dates to use specified common timezone
+	fixDatetimeTZ(tz, tzClassName);
 }
 
 
@@ -40,6 +48,10 @@ function fixDatetimeTZ(tz, tzClassName) {
 		return;
 	}
 
+	// server-side of gitweb produces datetime in UTC,
+	// so if tz is 'utc' there is no need for changes
+	var nochange = tz === 'utc';
+
 	// translate to timezone in '(-|+)HHMM' format
 	tz = normalizeTimezoneInfo(tz);
 
@@ -48,12 +60,222 @@ function fixDatetimeTZ(tz, tzClassName) {
 	for (var i = 0, len = classesFound.length; i < len; i++) {
 		var curElement = classesFound[i];
 
-		var epoch = parseRFC2822Date(curElement.innerHTML);
-		var adjusted = formatDateRFC2882(epoch, tz);
+		curElement.title = 'Click to change timezone';
+		if (!nochange) {
+			var epoch = parseRFC2822Date(curElement.innerHTML);
+			var adjusted = formatDateRFC2882(epoch, tz);
+
+			// curElement.innerHTML = adjusted; // does not work for Mozilla 1.17.2
+			curElement.firstChild.data = adjusted;
+		}
+	}
+}
+
+/**
+ * Adds triggers for UI to change common timezone used for dates in
+ * gitweb output: it marks up and/or creates item to click to invoke
+ * timezone change UI, creates timezone UI fragment to be attached,
+ * and instals appropriate onclick trigger (via event delegation).
+ *
+ * @param {String} tzSelected: pre-selected timezone,
+ *                             'utf' or 'local' or '(-|+)HHMM'
+ * @param {String} tzCookieName: name of cookie to store selection
+ * @param {String} tzClassName: specifies elements to install trigger
+ */
+function addChangeTZ(tzSelected, tzCookieName, tzClassName) {
+	// make link to timezone UI discoverable
+	addCssRule('.'+tzClassName + ':hover',
+	           'text-decoration: underline; cursor: help;');
+
+	// create form for selecting timezone (to be saved in a cookie)
+	var tzSelectFragment = document.createDocumentFragment();
+	tzSelectFragment = createChangeTZForm(tzSelectFragment,
+	                                      tzSelected, tzCookieName, tzClassName);
+
+	// event delegation handler for timezone selection UI (clicking on entry)
+	// see http://www.nczonline.net/blog/2009/06/30/event-delegation-in-javascript/
+	// assumes that there is no existing document.onclick handler
+	document.onclick = function onclickHandler(event) {
+		//IE doesn't pass in the event object
+		event = event || window.event;
+
+		//IE uses srcElement as the target
+		var target = event.target || event.srcElement;
+
+		switch (target.className) {
+		case tzClassName:
+			displayChangeTZForm(target, tzSelectFragment);
+			break;
+		} // end switch
+	};
+}
+
+/**
+ * Create DocumentFragment with UI for changing common timezone in
+ * which dates are shown in.
+ *
+ * @param {DocumentFragment} documentFragment: where attach UI
+ * @param {String} tzSelected: default (pre-selected) timezone
+ * @param {String} tzCookieName: name of cookie to save result of selection
+ * @returns {DocumentFragment}
+ */
+function createChangeTZForm(documentFragment, tzSelected, tzCookieName, tzClassName) {
+	var div = document.createElement("div");
+	div.className = 'popup';
+	///*
+	div.style.cssText =
+		'position: absolute; top: 0; right: 0; ' +
+		'border: 1pt solid; background-color: #f0f0f0;';
+	//*/
+
+	var closeButton = document.createElement('div');
+	closeButton.className = 'close-button';
+	///*
+	closeButton.style.cssText =
+		//'float: right; '+ // float doesn't work within absolutely positioned container
+		'position: absolute; top: 0px; right: 0px; '+
+		'border: 1px solid green; margin: 1px 1px 1px 1px; '+
+		'background-color: #fff0f0; font-weight: bold; font-size: 8px; text-align: center; ' +
+		'width: 10px; height: 10px; padding: 1px 1px 1px 1px;';
+	//*/
+	closeButton.title = '(click on this box to close)';
+	closeButton.appendChild(document.createTextNode('X'));
+	closeButton.onclick = function onclickCloseTZForm(event) {
+		event = event || window.event;
+		var target = event.target || event.srcElement;
+
+		removeChangeTZForm(documentFragment, target, tzClassName);
+	};
+	div.appendChild(closeButton);
+
+	div.appendChild(document.createTextNode('Select timezone: '));
+	var br = document.createElement('br');
+	br.clear = 'all';
+	div.appendChild(br);
+
+	var select = document.createElement("select");
+	select.name = "tzoffset";
+	//select.style.clear = 'all';
+
+	var timezones = generateTZList();
+	for (var i = 0, len = timezones.length; i < len; i++) {
+		var tzone = timezones[i];
+		var option = document.createElement("option");
+		if (tzone.value === tzSelected) {
+			option.defaultSelected = true;
+		}
+		option.value = tzone.value;
+		option.appendChild(document.createTextNode(tzone.descr));
+
+		select.appendChild(option);
+	}
+
+	select.onchange = function onTZFormChange(event) {
+		event = event || window.event;
+		var target = event.target || event.srcElement;
 
-		// curElement.innerHTML = adjusted; // does not work for Mozilla 1.17.2
-		curElement.firstChild.data = adjusted;
+		removeChangeTZForm(documentFragment, target, tzClassName);
+
+		var selected = target.options.item(target.selectedIndex);
+		if (selected) {
+			selected.defaultSelected = true;
+			setCookie(tzCookieName, selected.value, { expires: 7, path: '/' });
+			fixDatetimeTZ(selected.value, tzClassName);
+		}
+	};
+	// NOTE: onblur removal might be not necessary with close button
+	// NOTE: the same function (closure) as for closeButton.onclick
+	select.onblur = function onTZFormBlur(event) {
+		event = event || window.event;
+		var target = event.target || event.srcElement;
+
+		removeChangeTZForm(documentFragment, target, tzClassName);
+	};
+
+	div.appendChild(select);
+	documentFragment.appendChild(div);
+
+	return documentFragment;
+}
+
+
+/**
+ * Hide (remove from DOM) timezone change UI, ensuring that it is not
+ * garbage collected and that it can be re-enabled later.
+ *
+ * @param {DocumentFragment} documentFragment: contains detached UI
+ * @param {HTMLSelectElement} target: select element inside of UI
+ * @param {String} tzClassName: specifies element where UI was installed
+ * @returns {DocumentFragment} documentFragment
+ */
+function removeChangeTZForm(documentFragment, target, tzClassName) {
+	// find containing element, where we appended timezone selection UI
+	var container = target.parentNode;
+	while (container &&
+	       container.className !== tzClassName) {
+		container = container.parentNode;
+	}
+	// safety check if we found correct container,
+	// and if it isn't deleted already
+	if (!container ||
+	    container.className !== tzClassName ||
+	    container.lastChild.className !== 'popup') {
+		return documentFragment;
+	}
+
+	// timezone selection UI was appended as last child
+	// see also displayChangeTZForm function
+	var removed = container.removeChild(container.lastChild);
+	if (documentFragment.firstChild !== removed) {
+		// re-append it so it would be available for next time
+		documentFragment.appendChild(removed);
+	}
+	container.style.removeProperty('position');
+	if (!container.style.cssText) {
+		container.removeAttribute('style');
 	}
+
+	return documentFragment;
+}
+
+
+/**
+ * Display UI for changing common timezone for dates in gitweb output.
+ * To be used from 'onclick' event handler.
+ *
+ * @param {HTMLElement} target: where to install/display UI
+ * @param {DocumentFragment} tzSelectFragment: timezone selection UI
+ */
+function displayChangeTZForm(target, tzSelectFragment) {
+	// for absolute positioning to be related to target element
+	target.style.position = 'relative';
+
+	// show/display UI for changing timezone
+	target.appendChild(tzSelectFragment);
+}
+
+
+/**
+ * Generate list of timezones for creating timezone select UI
+ *
+ * @returns {Object[]} list of e.g. { value: '+0100', descr: 'GMT+01:00' }
+ */
+function generateTZList() {
+	var timezones = [
+		{ value: "utc",   descr: "UTC/GMT"},
+		{ value: "local", descr: "Local (per browser)"}
+	];
+
+	// generate all full hour timezones (no fractional timezones)
+	for (var x = -12, idx = timezones.length; x <= +14; x++, idx++) {
+		var hours = (x >= 0 ? '+' : '-') + padLeft(x >=0 ? x : -x, 2);
+		timezones[idx] = { value: hours + '00', descr: 'UTC' + hours + ':00'};
+		if (x === 0) {
+			timezones[idx].descr = 'UTC\u00B100:00'; // 'UTC&plusmn;00:00'
+		}
+	}
+
+	return timezones;
 }
 
 /* end of adjust-timezone.js */
diff --git a/gitweb/static/js/lib/common-lib.js b/gitweb/static/js/lib/common-lib.js
index b371391..faff9b6 100644
--- a/gitweb/static/js/lib/common-lib.js
+++ b/gitweb/static/js/lib/common-lib.js
@@ -64,7 +64,7 @@ function padLeft(input, width, ch) {
 
 
 /* ............................................................ */
-/* Ajax */
+/* Handling browser incompatibilities */
 
 /**
  * Create XMLHttpRequest object in cross-browser way
@@ -88,6 +88,31 @@ function createRequestObject() {
 }
 
 
+/**
+ * Insert rule giving specified STYLE to given SELECTOR at the end of
+ * first CSS stylesheet.
+ *
+ * @param {String} selector: CSS selector, e.g. '.class'
+ * @param {String} style: rule contents, e.g. 'background-color: red;'
+ */
+function addCssRule(selector, style) {
+	var stylesheet = document.styleSheets[0];
+
+	var theRules = [];
+	if (stylesheet.cssRules) {     // W3C way
+		theRules = stylesheet.cssRules;
+	} else if (stylesheet.rules) { // IE way
+		theRules = stylesheet.rules;
+	}
+
+	if (stylesheet.insertRule) {    // W3C way
+		stylesheet.insertRule(selector + ' { ' + style + ' }', theRules.length);
+	} else if (stylesheet.addRule) { // IE way
+		stylesheets.addRule(selector, style);
+	}
+}
+
+
 /* ............................................................ */
 /* Support for legacy browsers */
 
-- 
1.7.3
